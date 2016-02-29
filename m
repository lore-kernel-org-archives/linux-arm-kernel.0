From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 29 Feb 2016 10:44:38 +0800
Subject: [PATCH v2 1/2] ARM: mxs_defconfig: Cleanup mxs_defconfig
In-Reply-To: <1456399440-3646-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1456399440-3646-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <20160229024438.GN22051@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 25, 2016 at 12:23:59PM +0100, Michael Grzeschik wrote:
> From: Jan Luebbe <jlu@pengutronix.de>
> 
> Regenerate mxs_defconfig by running:
> make mxs_defconfig
> - Manually disable EXT2_FS and EXT3_FS
> make savedefconfig
> mv defconfig arch/arm/configs/mxs_defconfig
> 
> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

Applied both, thanks.
