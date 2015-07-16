From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 16 Jul 2015 09:47:57 +0900
Subject: [PATCH 3/3] ARM: exynos_defconfig: Enable NTC Thermistors support
In-Reply-To: <1436977965-7078-4-git-send-email-javier@osg.samsung.com>
References: <1436977965-7078-1-git-send-email-javier@osg.samsung.com>
 <1436977965-7078-4-git-send-email-javier@osg.samsung.com>
Message-ID: <55A6FF3D.5010701@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.07.2015 01:32, Javier Martinez Canillas wrote:
> The Exynos5420 Peach Pit and Exynos5800 Peach Pi Chromebooks have
> IIO based ADC thermistors. Enable built-in support for its driver.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> 
>  arch/arm/configs/exynos_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
