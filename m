From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 18 Dec 2013 14:42:39 +0800
Subject: [PATCH 2/2] ARM: imx: update imx_v6_v7_defconfig
In-Reply-To: <E1Vt0XX-0007Bw-Ry@rmk-PC.arm.linux.org.uk>
References: <20131217194130.GA4360@n2100.arm.linux.org.uk>
 <E1Vt0XX-0007Bw-Ry@rmk-PC.arm.linux.org.uk>
Message-ID: <20131218064237.GC6691@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 07:42:47PM +0000, Russell King wrote:
> Update the IMX v6/v7 defconfig for the SolidRun HummingBoard:
> - Add AT803X ethernet phy
> - Add consumer IR devices
> - Add imx-drm HDMI output

Dropped this line and applied the patch.

Shawn

> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/configs/imx_v6_v7_defconfig |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index 8d0c5a018ed7..53a5b521a474 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -118,6 +118,7 @@ CONFIG_SMC91X=y
>  CONFIG_SMC911X=y
>  CONFIG_SMSC911X=y
>  # CONFIG_NET_VENDOR_STMICRO is not set
> +CONFIG_AT803X_PHY=y
>  CONFIG_BRCMFMAC=m
>  # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
>  CONFIG_INPUT_EVDEV=y
> @@ -164,6 +165,9 @@ CONFIG_REGULATOR_MC13783=y
>  CONFIG_REGULATOR_MC13892=y
>  CONFIG_MEDIA_SUPPORT=y
>  CONFIG_MEDIA_CAMERA_SUPPORT=y
> +CONFIG_MEDIA_RC_SUPPORT=y
> +CONFIG_RC_DEVICES=y
> +CONFIG_IR_GPIO_CIR=y
>  CONFIG_V4L_PLATFORM_DRIVERS=y
>  CONFIG_SOC_CAMERA=y
>  CONFIG_VIDEO_MX3=y
> -- 
> 1.7.4.4
> 
