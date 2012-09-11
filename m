From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 11 Sep 2012 16:58:01 +0800
Subject: [GIT PULL 3/4] mxs clk device tree lookup
In-Reply-To: <1347350100-4674-4-git-send-email-shawn.guo@linaro.org>
References: <1347350100-4674-1-git-send-email-shawn.guo@linaro.org>
 <1347350100-4674-4-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120911085758.GB2481@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2012 at 03:54:58PM +0800, Shawn Guo wrote:
> The following changes since commit 0a77398b5a68e298f03b1c356c5100fa1decb2e1:
> 
>   Merge tag 'mxs-dt-3.7' into mxs/clk-dt-lookup (2012-09-11 14:15:00 +0800)
> 
> are available in the git repository at:
> 
> 
>   git://git.linaro.org/people/shawnguo/linux-2.6.git tags/mxs-clk-dt-lookup
> 
> for you to fetch changes up to 53f9443da63db38212e784b0aa205881168757aa:
> 
>   clk: mxs: replace imx23 clk_register_clkdev with clock DT lookup (2012-09-11 14:45:46 +0800)
> 
> ----------------------------------------------------------------
> mxs-clk-dt-lookup
> 
> It replaces clk_register_clkdev in mxs clock driver with DT lookup.
> The series depends on pull request mxs-dt-3.7 and Mike's clk branch
> below.
> 
git://git.linaro.org/people/mturquette/linux.git clk-3.7

The line got lost.  I just update the tag to add it back.

Regards,
Shawn

> ----------------------------------------------------------------
> Shawn Guo (2):
>       clk: mxs: replace imx28 clk_register_clkdev with clock DT lookup
>       clk: mxs: replace imx23 clk_register_clkdev with clock DT lookup
> 
>  .../devicetree/bindings/clock/imx23-clock.txt      |   76 [32m+++++++++++++[m
>  .../devicetree/bindings/clock/imx28-clock.txt      |   99 [32m+++++++++++++++++[m
>  arch/arm/boot/dts/imx23.dtsi                       |   16 [32m++[m[31m-[m
>  arch/arm/boot/dts/imx28.dtsi                       |   35 [32m+++++[m[31m-[m
>  drivers/clk/mxs/clk-imx23.c                        |   55 [32m++[m[31m--------[m
>  drivers/clk/mxs/clk-imx28.c                        |  113 [32m++[m[31m------------------[m
>  6 files changed, 242 insertions(+), 152 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/imx23-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/imx28-clock.txt
