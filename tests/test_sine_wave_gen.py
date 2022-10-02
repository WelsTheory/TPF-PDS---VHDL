import cocotb
from cocotb.clock import Clock
from cocotb.queue import Queue
from cocotb.triggers import Edge, RisingEdge, Timer

@cocotb.test()
async def test_sine_wave_generator(dut) -> None:

    dut.wave_period.value = 0

    # Create and start clcok
    clock = Clock(dut.CLOCK_100, 1, units="us")
    cocotb.start_soon(clock.start())

    dut.reset.value = 0
    await Timer(1, units="us")
    dut.reset.value = 1
    await Timer(1, units="us")


    await Timer(100, units="ms")