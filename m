From: mickamusset@gmail.com (Micka)
Date: Mon, 22 Feb 2016 20:26:07 +0100
Subject: max3107 & device tree
Message-ID: <CAF+MRtnjZfr5U482s+Hx8mU_LPO_j4fbgxm7vCe8D+s4R3Zqfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have a max3107 on my board, I'm trying to configure the device tree,
but it looks like that I need a clock :

http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/serial/maxim,max310x.txt?v=4.1

clocks: phandle to the IC source clock. clock-names: Should be "xtal"
if clock is an external crystal or "osc" if an external clock source
is used.

And I don't know what to put for the clock.

I would like to use xtal because I've a an external clock (quartz)
that is driving the max3107 but I don't know what to put for the
clocks = ?? I don't have clk20m referenced in the file
am33xx-clocks.dtsi .....

the frequency of my quartz is 1.8432MHz

any idea what I should do ?
