From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 10 Sep 2014 10:48:30 +0800
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Select CONFIG_RTC_DRV_ISL1208
In-Reply-To: <1410316841-19001-1-git-send-email-festevam@gmail.com>
References: <1410316841-19001-1-git-send-email-festevam@gmail.com>
Message-ID: <20140910024829.GG2341@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 09, 2014 at 11:40:41PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> The rtc isl1208 driver is used by mx6 nitrogen board, so let's enable it by
> default.
> 
> Generated this patch by doing:
> 
> - make imx_v6_v7_defconfig
> - make menuconfig and manually select CONFIG_RTC_DRV_ISL1208
> - make savedefconfig
> - cp defconfig arch/arm/configs/imx_v6_v7_defconfig
> 
> ,which results in some additional cleanups.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.
