From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 3 Jan 2017 10:03:32 +0100
Subject: [PATCH] ARM: davinci_all_defconfig: enable dumb vga-dac drm bridge
In-Reply-To: <1480065182-7095-1-git-send-email-bgolaszewski@baylibre.com>
References: <1480065182-7095-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <CAMpxmJVy34eLEGrrdo2TqPU=GSXi3YV2TJphbz1K3gHjatq7Cw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-11-25 10:13 GMT+01:00 Bartosz Golaszewski <bgolaszewski@baylibre.com>:
> This enables the dumb-vga-dac driver by default for davinci boards.
>
> The driver is needed for tilcdc support on da850-lcdk board.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/configs/davinci_all_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
> index b5e978f..ab1bf18 100644
> --- a/arch/arm/configs/davinci_all_defconfig
> +++ b/arch/arm/configs/davinci_all_defconfig
> @@ -127,6 +127,8 @@ CONFIG_REGULATOR_FIXED_VOLTAGE=y
>  CONFIG_REGULATOR_TPS6507X=y
>  CONFIG_DRM=m
>  CONFIG_DRM_TILCDC=m
> +CONFIG_DRM_BRIDGE=y
> +CONFIG_DRM_DUMB_VGA_DAC=m
>  CONFIG_FB=y
>  CONFIG_FIRMWARE_EDID=y
>  CONFIG_FB_DA8XX=y
> --
> 2.9.3
>

Hi Sekhar,

ping for this patch - it's been stuck on the list since November. I
suppose it got lost in your queue.

Thanks,
Bartosz
