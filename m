From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 11 May 2016 08:27:11 +0200
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: Enable Exynos MFC driver as
 module
In-Reply-To: <1462914448-24480-2-git-send-email-javier@osg.samsung.com>
References: <1462914448-24480-1-git-send-email-javier@osg.samsung.com>
 <1462914448-24480-2-git-send-email-javier@osg.samsung.com>
Message-ID: <5732D0BF.3020207@samsung.com>
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
> This patch depends on https://patchwork.kernel.org/patch/8970711/
> 
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)


Both patches look good but only exynos_defconfig ended in Patchwork.
This one did not... because you forgot to Cc the samsung-soc list.

Best regards,
Krzysztod
