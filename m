From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 14 Aug 2013 11:55:55 +0800
Subject: [PATCH 1/2] ARM: imx: Remove CONFIG_USB_PHY selection from
 defconfig
In-Reply-To: <1376308553-2824-1-git-send-email-festevam@gmail.com>
References: <1376308553-2824-1-git-send-email-festevam@gmail.com>
Message-ID: <20130814035553.GE16915@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 12, 2013 at 08:55:52AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Since commit 052a11d1 (usb: phy: make PHY driver selection possible by 
> controller drivers), CONFIG_USB_PHY is selected via drivers/usb/phy/Kconfig, so
> there is no need to select it via defconfig anymore.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/configs/imx_v6_v7_defconfig | 1 -
>  arch/arm/configs/mxs_defconfig       | 1 -

Please split it to avoid conflict between imx an mxs branches.

Shawn
