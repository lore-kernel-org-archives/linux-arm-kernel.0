From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 20 Nov 2012 22:33:54 +0800
Subject: [PATCH] ARM: mxs: Add SchulerControl SPS1 DTS file
In-Reply-To: <1353272909-11360-1-git-send-email-marex@denx.de>
References: <1353272909-11360-1-git-send-email-marex@denx.de>
Message-ID: <20121120143353.GD4882@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 18, 2012 at 10:08:29PM +0100, Marek Vasut wrote:
> Add DTS file for this custom board.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/boot/dts/imx28-sps1.dts |  169 ++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-mxs/mach-mxs.c     |    7 ++
>  2 files changed, 176 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx28-sps1.dts
> 
Applied with the following change amended.

Shawn

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b451a79..73f0a61 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -61,6 +61,7 @@ dtb-$(CONFIG_ARCH_MXS) += imx23-evk.dtb \
        imx28-cfa10049.dtb \
        imx28-evk.dtb \
        imx28-m28evk.dtb \
+       imx28-sps1.dtb \
        imx28-tx28.dtb
 dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
        omap3-beagle-xm.dtb \
