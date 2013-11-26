extern mod extra;

use std::rand::{task_rng, Rng};
use std::os::args;
use extra::time;

fn generate_list(list_size:uint, numbers_size:uint) -> ~[~[uint]]{
    let mut list = ~[];

    for _ in range(0,list_size) {
        let mut numbers = ~[];

        for _ in range(0, numbers_size) {
            let num = task_rng().gen_integer_range(0u, 100);
            numbers.push(num);
        }
        list.push(numbers);
    };
    return list;
}

fn sum_list(input_list: &~[uint]) -> uint {
    return input_list.iter().fold(0u, |a, &b| a + b);
}

fn calculate_val(numbers: ~[~[uint]]) -> uint {
    let partial = numbers.map(|ln| sum_list(ln));
    return sum_list(&partial);
}

fn main() {
    let input_args: ~[~str] = args();

    let list_size = from_str(input_args[1]).unwrap_or(0);
    let numbers_size = from_str(input_args[2]).unwrap_or(0);

    let numbers = generate_list(list_size, numbers_size);

    let t1 = time::get_time();
    let x = calculate_val(numbers);
    let t2 = time::get_time();
    let total = ((t2.nsec - t1.nsec) as float) / 1000000.0;

    println! ("[Rust ! Array Sum] Elapsed time: {} msecs ( Result: {} )", total, x);
}
