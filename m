From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 10 Sep 2014 09:51:06 +0800
Subject: [PATCH] ARM: imx_v4_v5_defconfig: Select CONFIG_IMX_WEIM
In-Reply-To: <1409927663-8871-1-git-send-email-festevam@gmail.com>
References: <1409927663-8871-1-git-send-email-festevam@gmail.com>
Message-ID: <20140910015104.GD2341@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 05, 2014 at 11:34:23AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> The imx weim driver is used by some mx27/mx1 boards, so let's enable it by
> default.
> 
> Generated this patch by doing:
> 
> - make imx_v4_v5_defconfig
> - make menuconfig and manually select CONFIG_IMX_WEIM
> - make savedefconfig
> - cp defconfig arch/arm/configs/imx_v4_v5_defconfig
> 
> ,which results in some additional cleanups.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.
