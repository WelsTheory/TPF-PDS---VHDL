import cocotb
from cocotb.clock import Clock
from cocotb.queue import Queue
from cocotb.triggers import Edge, RisingEdge, Timer

@cocotb.test()
async def test_sine_wave_generator(dut) -> None:

    dut.rst = 0
    await Timer(1, units="us")
    dut.rst = 1

    # Create and start clcok
    clock = Clock(dut.clk, 1, units="us")
    cocotb.start_soon(clock.start())

    await Timer(10, units="us")

    dut.rst = 0
    await Timer(1, units="us")
    dut.rst = 1
    await Timer(10, units="us")