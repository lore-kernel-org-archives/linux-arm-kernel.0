From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 2 Jun 2016 09:43:33 -0400
Subject: [PATCH 1/4] ARM: multi_v7_defconfig: Enable Trats2 audio codec,
 touchscreen and sensors
In-Reply-To: <1464846916-3110-1-git-send-email-k.kozlowski@samsung.com>
References: <1464846916-3110-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <2cc696db-554b-643e-d075-a3b47da33587@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 06/02/2016 01:55 AM, Krzysztof Kozlowski wrote:
> The Exynos4412-based Trats2 board has CM36651 proximity/ambient light
> sensor, MMS114 touchscreen and Wolfson Microelectronics WM1811 CODEC.
> Enable them in defconfig to get some testing coverage and use its
> features.
> 
> While saving defconfig the SND_SOC_ODROIDX2 is removed because it does
> not exist since commit ee12a817bb4b ("ASoC: samsung: Remove unused
> Odroid x2/u3 machine driver").
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
