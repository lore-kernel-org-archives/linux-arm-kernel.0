From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 26 Jul 2013 13:07:03 -0700
Subject: Zynq clk fixes
In-Reply-To: <51F26716.6030701@monstr.eu>
References: <51F26716.6030701@monstr.eu>
Message-ID: <20130726200703.7598.86150@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Michal Simek (2013-07-26 05:09:58)
> Hi Mike, [cc: Arnd and Olof]
> 
> Soren has found two bug fixes in zynq clk code.
> Can you please add these two patches to your tree?
> Will be great if you can add them to v3.11.
> 
> Arnd, Olof: I expect that all these clock changes should go through Mike.
> If I am wrong please let me know.

Looks right to me. Do these fix regressions in the current -rc cycle?

Regards,
Mike

> 
> Thanks,
> Michal
> 
> 
> The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:
> 
>   Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)
> 
> are available in the git repository at:
> 
>   git://git.xilinx.com/linux-xlnx.git tags/zynq-clk-fixes-for-3.11
> 
> for you to fetch changes up to 97d58aef394831f6f0583653de29e03886a0e09e:
> 
>   clk/zynq/clkc: Add CLK_SET_RATE_PARENT flag to ethernet muxes (2013-07-17 08:36:53 +0200)
> 
> ----------------------------------------------------------------
> arm: Xilinx Zynq clock fixes for v3.11
> 
> - Fix watchdog clock registration
> - Fix gem clock propagation
> 
> ----------------------------------------------------------------
> Soren Brinkmann (2):
>       clk/zynq/clkc: Add dedicated spinlock for the SWDT
>       clk/zynq/clkc: Add CLK_SET_RATE_PARENT flag to ethernet muxes
> 
>  drivers/clk/zynq/clkc.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> -- 
> Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
> w: www.monstr.eu p: +42-0-721842854
> Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
> Maintainer of Linux kernel - Xilinx Zynq ARM architecture
> Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform
