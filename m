From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 30 May 2016 08:36:19 +0200
Subject: [PATCH 1/2] ARM: exynos_defconfig: Enable MFC driver as module
In-Reply-To: <1462914448-24480-1-git-send-email-javier@osg.samsung.com>
References: <1462914448-24480-1-git-send-email-javier@osg.samsung.com>
Message-ID: <574BDF63.1090407@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/10/2016 11:07 PM, Javier Martinez Canillas wrote:
> Exynos SoCs have a Multi Format Video Hardware Codec (MFC) IP block that
> can be used to {en,de}code video streams by hardware. Enable support for
> its driver as a module so the MFC can be tested.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> 
> This patch depends on https://patchwork.kernel.org/patch/8970731/
> 
>  arch/arm/configs/exynos_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Thanks, applied both.

Krzysztof
