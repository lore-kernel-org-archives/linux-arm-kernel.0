From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 25 Jan 2018 15:40:32 +0800
Subject: [PATCH 1/5] ARM: dts: imx23: Pass unit address and reg to IOMUX
 node
In-Reply-To: <1514383478-32544-1-git-send-email-festevam@gmail.com>
References: <1514383478-32544-1-git-send-email-festevam@gmail.com>
Message-ID: <20180125074031.GB9309@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 27, 2017 at 12:04:34PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Pass unit address and reg to IOMUX node to fix the following build
> warning with W=1:
> 
> arch/arm/boot/dts/imx23-evk.dtb: Warning (simple_bus_reg): Node /apb at 80000000/apbh at 80000000/pinctrl at 80018000/gpmi-pins-fixup missing or empty reg/ranges property
> arch/arm/boot/dts/imx23-evk.dtb: Warning (simple_bus_reg): Node /apb at 80000000/apbh at 80000000/pinctrl at 80018000/mmc0-pins-fixup missing or empty reg/ranges property
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied all, thanks.
