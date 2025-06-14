module example_module;
    int data_a = 10;
    int data_b = 20;
    int sum_result;
    int my_counter = 5;
    int fixed_val; // Declare outside initial block

    initial begin
        // Function with return value
        sum_result = add_values(data_a, data_b);
        $display("Sum of %0d and %0d is: %0d", data_a, data_b, sum_result);

        // Function with ref and automatic
        increment_counter(my_counter);
        $display("My counter after increment: %0d", my_counter);

        // Function without arguments
        fixed_val = get_default_value();
        $display("Default value: %0d", fixed_val);
    end

    // Function returning int
    function int add_values(input int a, input int b);
        return a + b;
    endfunction

    // Function using 'ref' must be 'automatic'
    function automatic void increment_counter(ref int count);
        count = count + 1;
    endfunction

    // Simple function without arguments
    function int get_default_value();
        return 10;
    endfunction
endmodule
