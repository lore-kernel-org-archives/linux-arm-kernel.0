From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 04 Dec 2014 16:52:24 +0100
Subject: [GIT PULL] Xilinx Zynq dt changes for v3.19
In-Reply-To: <547C2758.1020707@monstr.eu>
References: <547C2758.1020707@monstr.eu>
Message-ID: <2225642.AaCXFBT9t1@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 December 2014 09:31:20 Michal Simek wrote:
> Hi,
> 
> please pull these 4 patches to your arm-soc tree.
> There will be conflict in DT for parallella because of fix
> "ARM: dts: zynq: Enable PL clocks for Parallella"
> (sha1: 92c9e0c780e61f821ab8a08f0d4d4fd33ba1197c)
> 
> Resolution of this conflict is:
> &clkc {
> 	ps-clk-frequency = <33333333>;
> 	fclk-enable = <0xf>;
> };

Pulled into next/dt

> ----------------------------------------------------------------
> Andreas F?rber (1):
>       Documentation: devicetree: Fix Xilinx VDMA specification
> 
> Peter Crosthwaite (3):
>       doc: dt: vendor-prefixes: Add Digilent Inc
>       arm: dts: zynq: Move crystal freq. to board level
>       arm: dts: zynq: Add Digilent ZYBO board

Please take tare to always use the prefix that is used most commonly
for each subsystem when writing the patch changelog. Here, it should have
been "ARM:" instead of "arm:". The actual changes are all good though.

Thanks,

	Arnd
