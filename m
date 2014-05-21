From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 20 May 2014 22:12:56 -0700
Subject: [GIT PULL] Xilinx Zynq clk patches for v3.16
In-Reply-To: <537B65CA.4070604@monstr.eu>
References: <537B65CA.4070604@monstr.eu>
Message-ID: <20140521051256.9521.88119@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Michal Simek (2014-05-20 07:25:14)
> Hi Mike,
> 
> please pull these 2 patches to your tree.
> 
> Thanks,
> Michal
> 
> The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:
> 
>   Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)
> 
> are available in the git repository at:
> 
>   git://git.xilinx.com/linux-xlnx.git tags/zynq-clk-for-3.16
> 
> for you to fetch changes up to 44731f5db44087f54d4e1ed6a460c75552fadcf7:
> 
>   clk: si570: Fix email address specifiction (2014-05-20 16:18:18 +0200)

Pulled.

Regards,
Mike

> 
> ----------------------------------------------------------------
> arm: Xilinx Zynq clk patches for v3.16
> 
> - Keep debug clocks in bootup state
> - Fix email address in si570
> 
> ----------------------------------------------------------------
> Michal Simek (1):
>       clk: si570: Fix email address specifiction
> 
> Soren Brinkmann (1):
>       clk: zynq: Leave debug clocks in bootup state
> 
>  drivers/clk/clk-si570.c |  2 +-
>  drivers/clk/zynq/clkc.c | 12 ++++++++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> 
> 
> -- 
> Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
> w: www.monstr.eu p: +42-0-721842854
> Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
> Maintainer of Linux kernel - Xilinx Zynq ARM architecture
> Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform
> 
> 
