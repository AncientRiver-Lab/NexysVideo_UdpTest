onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib ETH_CLKGEN_opt

do {wave.do}

view wave
view structure
view signals

do {ETH_CLKGEN.udo}

run -all

quit -force
