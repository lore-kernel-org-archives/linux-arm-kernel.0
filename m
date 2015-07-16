From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 16 Jul 2015 09:48:15 +0900
Subject: [PATCH 2/3] ARM: multi_v7_defconfig: Enable NTC Thermistors
 support
In-Reply-To: <1436977965-7078-3-git-send-email-javier@osg.samsung.com>
References: <1436977965-7078-1-git-send-email-javier@osg.samsung.com>
 <1436977965-7078-3-git-send-email-javier@osg.samsung.com>
Message-ID: <55A6FF4F.4080002@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.07.2015 01:32, Javier Martinez Canillas wrote:
> The Exynos5420 Peach Pit and Exynos5800 Peach Pi Chromebooks have
> IIO based ADC thermistors. Enable module support for its driver
> and also for the needed Exynos ADC driver.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
> 
>  arch/arm/configs/multi_v7_defconfig | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
