# MIQ-Benchmark
## Usage

Firstly, clone this repository in the workspace path. 

```sh
  # ~/workspace
  git clone https://github.com/lenovo/miq-benchmark.git
```


After, go to manageiq project and run the following command:

```sh
  # ~/workspace/manageIQ
  ruby ../miq-benchmark/miq-benchmark.rb 
```

The standard output is:

```sh
EVM:ManageIQ started!
first refresh OK!
all refresh OK!
EVM:ManageIQ stoped!
Time EVM Start: 95.77281175
Time EVM Stop: 181.140067787
Time Refresh one provider: 28.15599608
Time Refresh all providers: 4.907862181
System Usage: {:mem=>["49.8986", "50.0634", "50.0761", "50.2536", "50.3931", "50.6214", "50.6467", "50.7228", "50.8369",
              "85.6074", "85.6581", "85.7469", "86.0005", "86.102", "86.1146", "86.4824", "86.6726", "86.9135", "87.6363",
              "88.0294", "88.0167", "88.1182", "85.1382", "85.5567", "86.1146", "86.4824", "85.0368", "85.4806", "85.7723",
              "86.1907", "86.4824", "86.5077", "86.5458", "86.5204", "86.5331", "84.073", "81.5623", "79.1402", "75.7165",
              "48.77", "48.7953", "48.7953", "48.8207", "48.8207", "48.8207", "48.8334", "48.8334", "48.8207", "48.8207",
              "49.3026", "49.3026", "49.3026", "49.3026", "49.3152", "49.3533", "49.3152", "49.3026", "49.3152", "42.8734",
              "37.6363", "37.611", "37.6363", "36.0385", "36.5077", "36.9135", "37.3954", "37.5983"],
              :cpu=>["0,74", "0,74", "0,84", "0,84", "0,84", "0,84", "0,93", "0,93", "0,93", "0,93", "1,18", "1,18", "1,18",
              "1,71", "1,71", "2,21", "2,21", "2,21", "2,21", "2,44", "2,44", "2,44", "2,44", "3,04", "3,04", "3,04", "3,04",
              "3,60", "3,60", "3,60", "3,79", "3,79", "3,79", "3,79", "4,37", "4,37", "4,37", "4,37", "4,50", "4,50", "4,50",
              "4,50", "4,46", "4,46", "4,46", "4,46", "4,46", "4,58", "4,58", "4,58", "4,58", "4,38", "4,38", "4,38", "4,38",
              "4,19", "4,19", "4,19", "4,19", "3,93", "3,93", "3,93", "3,93", "3,78", "3,78", "3,78", "3,78", "3,78", "3,55",
              "3,55", "3,55", "3,55", "3,35", "3,35", "3,35", "3,35", "3,16", "3,16", "3,16", "3,16", "3,07", "3,07", "3,07",
              "3,07", "3,07", "2,90", "2,90", "2,90", "2,90", "2,75", "2,75", "2,75", "2,75", "2,61", "2,61", "2,61", "2,61",
              "2,40", "2,40", "2,40", "2,40", "2,29", "2,29", "2,29", "2,29", "2,29", "2,10", "2,10", "2,10", "2,10", "2,02",
              "2,02", "2,02", "2,02", "1,93", "1,93", "1,93", "1,93", "1,78", "1,78", "1,78", "1,78", "1,72", "1,72", "1,72",
              "1,72", "1,72", "1,74", "1,74", "1,74", "1,74", "1,68", "1,68", "1,68", "1,68", "1,54", "1,54", "1,54", "1,54"], 
              :disk=>["16.00", "16.00", "16.00", "16.00", "16.00",
              "16.00", "16.00", "16.00", "16.00", "16.00", "16.00", "16.00", "16.00", "16.00", "16.00", "16.00", "16.00", "16.00",
              "16.00", "16.00", "16.00", "16.00", "16.00", "16.00", "16.00", "16.00", "16.00", "16.00", "16.00", "16.00", "18.00",
              "18.00", "18.00", "18.00", "18.00", "18.00", "18.00", "18.00", "18.00", "18.00", "18.00", "18.00", "18.00", "18.00"]}
```
The `System Usage` is the percentage of memory, cpu and disk used before, during and after the execution.
