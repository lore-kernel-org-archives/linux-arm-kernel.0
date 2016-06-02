From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 02 Jun 2016 09:58:16 +0200
Subject: [PATCH 1/4] ARM: multi_v7_defconfig: Enable Trats2 audio codec,
 touchscreen and sensors
In-Reply-To: <1464846916-3110-1-git-send-email-k.kozlowski@samsung.com>
References: <1464846916-3110-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <13343743.82cem7RKKT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, June 2, 2016 7:55:13 AM CEST Krzysztof Kozlowski wrote:
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
> 

All four look good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de> 
