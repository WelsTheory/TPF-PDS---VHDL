import cocotb
from cocotb.clock import Clock
from cocotb.queue import Queue
from cocotb.triggers import Edge, RisingEdge, Timer

@cocotb.test()
async def test_sine_wave_generator(dut) -> None:

    dut.i_fcw.value = 100

    # Create and start clcok
    clock = Clock(dut.i_clk, 100, units="ns")
    cocotb.start_soon(clock.start())

    dut.i_rst_h.value = 1
    dut.input_stream.value = 0
    await Timer(20, units="ns")
    dut.i_rst_h.value = 0
    await Timer(1, units="ms")
    dut.input_stream.value = 1
    await Timer(1, units="ms")
    dut.input_stream.value = 2
    await Timer(1, units="ms")
    dut.input_stream.value = 3
    await Timer(1, units="ms")
    dut.input_stream.value = 0

    await Timer(10, units="ms")