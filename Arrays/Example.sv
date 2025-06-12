module array_demonstration;

  // 1. Static Array
  int static_array[5];

  // 2. Dynamic Array
  int dynamic_array[];

  // 3. Packed Array
  logic [3:0] [7:0] packed_data; // 4 elements, each 8 bits = 32 bits total

  // 4. Unpacked Array
  int unpacked_array[2][3];

  // 5. Associative Array
  int assoc_array[string];

  // 6. Queue
  int queue_data[$];

  initial begin
    $display("--- SystemVerilog Array Demonstration ---");

    // Static Array Operations
    $display("\n--- Static Array ---");
    for (int i = 0; i < 5; i++) begin
      static_array[i] = (i + 1) * 10;
    end
    $display("Static Array elements: %p", static_array);
    $display("Static Array size: %0d", static_array.size());

    // Dynamic Array Operations
    $display("\n--- Dynamic Array ---");
    dynamic_array = new[3]; // Allocate initial size
    for (int i = 0; i < dynamic_array.size(); i++) begin
      dynamic_array[i] = (i + 1) * 100;
    end
    $display("Dynamic Array (initial) elements: %p", dynamic_array);

    dynamic_array = new[5](dynamic_array); // Resize and copy old elements
    dynamic_array[3] = 400;
    dynamic_array[4] = 500;
    $display("Dynamic Array (resized) elements: %p", dynamic_array);
    $display("Dynamic Array size: %0d", dynamic_array.size());
    dynamic_array = new[0]; // Deallocate
    $display("Dynamic Array (deallocated) size: %0d", dynamic_array.size());


    // Packed Array Operations
    $display("\n--- Packed Array ---");
    packed_data = 'hAABBCCDD; // Assign a 32-bit hex value
    $display("Packed Data (hex): %h", packed_data);
    $display("Individual 8-bit elements of Packed Data:");
    for (int i = 0; i < 4; i++) begin
      $display("  packed_data[%0d]: %h", i, packed_data[i]);
    end
    $display("Accessing a specific bit: packed_data[0][7] = %b", packed_data[0][7]); // Access MSB of the first 8-bit element

    // Unpacked Array Operations
    $display("\n--- Unpacked Array ---");
    for (int i = 0; i < 2; i++) begin
      for (int j = 0; j < 3; j++) begin
        unpacked_array[i][j] = (i + 1) * 10 + j;
      end
    end
    $display("Unpacked Array elements: %p", unpacked_array);
    $display("Unpacked Array dimension 0 size: %0d", unpacked_array.size());
    $display("Unpacked Array dimension 1 size: %0d", unpacked_array[0].size()); // Size of inner array


    // Associative Array Operations
    $display("\n--- Associative Array ---");
    assoc_array["apple"] = 10;
    assoc_array["banana"] = 20;
    assoc_array["orange"] = 15;
    assoc_array[string'("grape")] = 5; // Using string cast for clarity

    $display("Associative Array: %p", assoc_array);
    $display("Value for 'banana': %0d", assoc_array["banana"]);

    // Check if a key exists
    if (assoc_array.exists("apple")) begin
      $display("'apple' key exists.");
    end else begin
      $display("'apple' key does not exist.");
    end

    // Delete an element
    assoc_array.delete("orange");
    $display("Associative Array after deleting 'orange': %p", assoc_array);
    $display("Associative Array size: %0d", assoc_array.num()); // Use num() for associative array size


    // Queue Operations
    $display("\n--- Queue ---");
    queue_data.push_back(100); // Add to end
    queue_data.push_back(200);
    queue_data.push_front(50);  // Add to front
    queue_data.push_back(300);

    $display("Queue elements: %p", queue_data);
    $display("Queue size: %0d", queue_data.size());

    int front_val = queue_data.pop_front(); // Remove from front
    $display("Popped from front: %0d", front_val);
    $display("Queue after pop_front: %p", queue_data);

    int back_val = queue_data.pop_back(); // Remove from back
    $display("Popped from back: %0d", back_val);
    $display("Queue after pop_back: %p", queue_data);

    queue_data.delete(); // Clear the queue
    $display("Queue after delete: %p", queue_data);
    $display("Queue size after delete: %0d", queue_data.size());

    $display("\n--- End of Demonstration ---");
  end

endmodule