From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 1 Sep 2016 12:53:25 +0200
Subject: [PATCH 0/6] pinctrl: s3c/samsung: Add header with values used for
 configuration
In-Reply-To: <1472721715-2833-1-git-send-email-k.kozlowski@samsung.com>
References: <1472721715-2833-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <f235a3a0-36cb-7816-6f57-4a09d63d109f@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 09/01/2016 11:21 AM, Krzysztof Kozlowski wrote:
> Hi,
> 
> Extend previous patchset (v2) [1] to older, legacy platforms.
> This depends on v2 of prevoius patchset.
> 
> 
> Changes in DTS/DTSI generated with:
> sed -i -e 's/samsung,pin-drv = <0>;$/samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;/' arch/arm/boot/dts/s5p*
> sed -i -e 's/samsung,pin-drv = <2>;$/samsung,pin-drv = <EXYNOS4_PIN_DRV_LV2>;/' arch/arm/boot/dts/s5p*
> sed -i -e 's/samsung,pin-drv = <1>;$/samsung,pin-drv = <EXYNOS4_PIN_DRV_LV3>;/' arch/arm/boot/dts/s5p*
> sed -i -e 's/samsung,pin-drv = <3>;$/samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;/' arch/arm/boot/dts/s5p*
> 

Besides the comment for patch 1/6, the series looks good to me.
So when posting v2 feel free to add:

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
