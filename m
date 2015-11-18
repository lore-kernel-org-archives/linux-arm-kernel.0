From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 18 Nov 2015 21:47:59 +0900
Subject: [PATCH] ARM: multi_v7_defconfig: Build ChromeOS EC drivers as
 modules
In-Reply-To: <1447775924-2189-1-git-send-email-javier@osg.samsung.com>
References: <1447775924-2189-1-git-send-email-javier@osg.samsung.com>
Message-ID: <564C737F.9060405@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 18.11.2015 o 00:58, Javier Martinez Canillas pisze:
> Since the multi_v7_defconfig is used to build an image for different
> platforms, the options should be enabled as module whenever possible.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> The patch was tested on an Exynos5800 Peach Pi Chromebook
> and the drivers' modules were correctly autoloaded.
> 
>  arch/arm/configs/multi_v7_defconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

I suppose this could go through Samsung-soc. I got few other patches for
multi_v7.

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
