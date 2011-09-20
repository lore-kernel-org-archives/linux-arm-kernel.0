From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 21 Sep 2011 01:13:48 +0200
Subject: [PATCH 5/5] omap2plus_defconfig: Enable omap3isp and MT9T111
	sensor drivers
In-Reply-To: <1316530612-23075-6-git-send-email-deepthy.ravi@ti.com>
References: <1316530612-23075-1-git-send-email-deepthy.ravi@ti.com>
	<1316530612-23075-6-git-send-email-deepthy.ravi@ti.com>
Message-ID: <201109210113.49151.laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Deepthy,

Thanks for the patch.

On Tuesday 20 September 2011 16:56:52 Deepthy Ravi wrote:
> Enables multimedia driver, media controller api,
> v4l2-subdev-api, omap3isp and mt9t111 sensor
> drivers in omap2plus_defconfig.
> 
> Signed-off-by: Deepthy Ravi <deepthy.ravi@ti.com>
> ---
>  arch/arm/configs/omap2plus_defconfig |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig
> b/arch/arm/configs/omap2plus_defconfig index d5f00d7..548823d 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -133,6 +133,16 @@ CONFIG_TWL4030_WATCHDOG=y
>  CONFIG_REGULATOR_TWL4030=y
>  CONFIG_REGULATOR_TPS65023=y
>  CONFIG_REGULATOR_TPS6507X=y
> +CONFIG_MEDIA_SUPPORT=y
> +CONFIG_MEDIA_CONTROLLER=y
> +CONFIG_VIDEO_DEV=y
> +CONFIG_VIDEO_V4L2_COMMON=y
> +CONFIG_VIDEO_ALLOW_V4L1=y
> +CONFIG_VIDEO_V4L1_COMPAT=y
> +CONFIG_VIDEO_V4L2_SUBDEV_API=y
> +CONFIG_VIDEO_MEDIA=y
> +CONFIG_VIDEO_MT9T111=y
> +CONFIG_VIDEO_OMAP3=y

Shouldn't they be compiled as modules instead ?

>  CONFIG_FB=y
>  CONFIG_FIRMWARE_EDID=y
>  CONFIG_FB_MODE_HELPERS=y

-- 
Regards,

Laurent Pinchart
