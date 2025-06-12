module enum_demonstration;

  // Simple Enum Declaration
  typedef enum {
    STATE_IDLE,    // Automatically assigned 0
    STATE_CONFIG,  // Automatically assigned 1
    STATE_RUNNING, // Automatically assigned 2
    STATE_ERROR    // Automatically assigned 3
  } fsm_state_e;

  // Enum with explicit values
  typedef enum logic [2:0] { // Explicitly set data type to 3 bits
    OP_READ  = 3'b001,
    OP_WRITE = 3'b010,
    OP_RESET = 3'b100
  } operation_e;

  // Enum with a range (SystemVerilog 2012 feature for explicit values within range)
  // Note: While you can define a range for the underlying type (like logic [7:0]),
  // the 'range' itself within the enum definition is more about how the
  // values are *assigned* if not explicit. For explicit value ranges,
  // it's usually better to just assign the values as done with operation_e.
  // This example focuses on the common usage of explicit values.
  typedef enum {
    PRIORITY_LOW    = 1,
    PRIORITY_MEDIUM = 5,
    PRIORITY_HIGH   = 10
  } priority_e;


  // Declare variables of enum types
  fsm_state_e current_state;
  operation_e current_op;
  priority_e  task_priority;

  initial begin
    $display("--- SystemVerilog Enum Demonstration ---");

    // --- Basic Enum Usage (fsm_state_e) ---
    $display("\n--- FSM State Enum ---");
    current_state = STATE_IDLE;
    $display("Initial state: %s (value: %0d)", current_state.name(), current_state);

    current_state = STATE_CONFIG;
    $display("Current state: %s (value: %0d)", current_state.name(), current_state);

    // Using .next() and .prev()
    current_state = current_state.next(); // Should go to STATE_RUNNING
    $display("State after .next(): %s (value: %0d)", current_state.name(), current_state);

    current_state = current_state.prev(); // Should go back to STATE_CONFIG
    $display("State after .prev(): %s (value: %0d)", current_state.name(), current_state);

    // Using .first() and .last()
    $display("First state: %s (value: %0d)", fsm_state_e.first().name(), fsm_state_e.first());
    $display("Last state: %s (value: %0d)", fsm_state_e.last().name(), fsm_state_e.last());

    // Iterating through enum values
    $display("Iterating through FSM states:");
    for (fsm_state_e s = fsm_state_e.first(); s <= fsm_state_e.last(); s = s.next()) begin
      $display("  State: %s (value: %0d)", s.name(), s);
    end

    // --- Enum with Explicit Values (operation_e) ---
    $display("\n--- Operation Enum ---");
    current_op = OP_READ;
    $display("Current operation: %s (value: %b)", current_op.name(), current_op);

    current_op = OP_WRITE;
    $display("Current operation: %s (value: %b)", current_op.name(), current_op);

    // Type checking - direct integer assignment is not allowed
    // current_op = 3'b011; // ERROR: Type mismatch, cannot assign int to enum
    current_op = operation_e'(3'b011); // OK: Explicit cast
    $display("Current operation after explicit cast: %s (value: %b)", current_op.name(), current_op); // .name() for unlisted values might be simulator dependent or default to null

    current_op = OP_RESET;
    $display("Current operation: %s (value: %b)", current_op.name(), current_op);


    // --- Enum with Custom Priority Values (priority_e) ---
    $display("\n--- Priority Enum ---");
    task_priority = PRIORITY_LOW;
    $display("Task priority: %s (value: %0d)", task_priority.name(), task_priority);

    task_priority = PRIORITY_HIGH;
    $display("Task priority: %s (value: %0d)", task_priority.name(), task_priority);

    // Using .next() and .prev() with non-sequential values
    // Note: .next() and .prev() still navigate based on the *declaration order*,
    // not the numerical value.
    $display("Priority .first(): %s (value: %0d)", priority_e.first().name(), priority_e.first()); // PRIORITY_LOW
    $display("Priority .last(): %s (value: %0d)", priority_e.last().name(), priority_e.last());   // PRIORITY_HIGH

    task_priority = PRIORITY_LOW;
    task_priority = task_priority.next(); // Goes to PRIORITY_MEDIUM
    $display("Priority .next() from LOW: %s (value: %0d)", task_priority.name(), task_priority);

    task_priority = task_priority.next(); // Goes to PRIORITY_HIGH
    $display("Priority .next() from MEDIUM: %s (value: %0d)", task_priority.name(), task_priority);

    task_priority = task_priority.prev(); // Goes to PRIORITY_MEDIUM
    $display("Priority .prev() from HIGH: %s (value: %0d)", task_priority.name(), task_priority);


    $display("\n--- End of Enum Demonstration ---");
  end

endmodule