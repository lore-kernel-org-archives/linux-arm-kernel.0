From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 26 Nov 2015 09:31:59 +0900
Subject: [PATCH] ARM: dts: Remove unneeded GPIO include in
 exynos4412-odroidu3
In-Reply-To: <1448453483-3338-1-git-send-email-javier@osg.samsung.com>
References: <1448453483-3338-1-git-send-email-javier@osg.samsung.com>
Message-ID: <565652FF.8050305@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.11.2015 21:11, Javier Martinez Canillas wrote:
> The <dt-bindings/gpio/gpio.h> header is already included in the
> exynos4412-odroid-common DTSI so there's no need to do it again
> in the DTS file.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> 
>  arch/arm/boot/dts/exynos4412-odroidu3.dts | 1 -
>  1 file changed, 1 deletion(-)


Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
