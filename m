From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 1 Mar 2016 21:33:18 +0800
Subject: [PATCH v2 1/2] ARM: imx_v4_v5_defconfig: Cleanup
 imx_v4_v5_defconfig
In-Reply-To: <1456741578-3202-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1456741578-3202-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <20160301133318.GU22051@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 29, 2016 at 11:26:17AM +0100, Michael Grzeschik wrote:
> From: Jan Luebbe <jlu@pengutronix.de>
> 
> Regenerate imx_v4_v5_defconfig by running:
> make imx_v4_v5_defconfig
> - Manually disable EXT2_FS and EXT3_FS
> make savedefconfig
> mv defconfig arch/arm/configs/imx_v4_v5_defconfig
> 
> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

Applied both, thanks.
