From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 18 Dec 2013 21:12:19 -0800
Subject: [GIT PULL] Xilinx Zynq clk changes for v3.14
In-Reply-To: <52B16A4B.1000706@monstr.eu>
References: <52B16A4B.1000706@monstr.eu>
Message-ID: <20131219051219.18119.26127@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Michal Simek (2013-12-18 01:26:35)
> Hi Mike,
> 
> As we discussed it is better for you to get pull request with signed tags.
> That's why I am sending you pull request for 2 patches which we have in queue which
> should go to v3.14.

Michal,

Thanks much for the pull request. In the future it is a bit easier if
you base your pull request on the tip of clk-next, but it's not a big
deal.

Shouldn't the change to zynq-7000.dtsi go through the arm-soc tree
instead of the clk tree?

Regards,
Mike

> 
> Thanks,
> Michal
> 
> 
> The following changes since commit dc1ccc48159d63eca5089e507c82c7d22ef60839:
> 
>   Linux 3.13-rc2 (2013-11-29 12:57:14 -0800)
> 
> are available in the git repository at:
> 
>   git://git.xilinx.com/linux-xlnx.git tags/zynq-clk-for-3.14
> 
> for you to fetch changes up to eda9488d741085f79318884690db139712a1b019:
> 
>   arm: dt: zynq: Add fclk-enable property to clkc node (2013-12-11 17:48:48 +0100)
> 
> ----------------------------------------------------------------
> arm: Xilinx Zynq clk patches for v3.14
> 
> - Add support for fclk-enable feature
> 
> ----------------------------------------------------------------
> Soren Brinkmann (2):
>       clk/zynq/clkc: Add 'fclk-enable' feature
>       arm: dt: zynq: Add fclk-enable property to clkc node
> 
>  Documentation/devicetree/bindings/clock/zynq-7000.txt |  4 ++++
>  arch/arm/boot/dts/zynq-7000.dtsi                      |  1 +
>  drivers/clk/zynq/clkc.c                               | 18 +++++++++++++++---
>  3 files changed, 20 insertions(+), 3 deletions(-)
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
