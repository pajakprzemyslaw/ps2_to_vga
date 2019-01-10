onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+pll_125_to_25 -L unisims_ver -L unimacro_ver -L secureip -L xil_defaultlib -L xpm -O5 xil_defaultlib.pll_125_to_25 xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {pll_125_to_25.udo}

run -all

endsim

quit -force
