From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 28 Apr 2016 12:04:26 -0400
Subject: [PATCH] ARM: exynos_defconfig: Disable big.LITTLE switcher
In-Reply-To: <1493315.8NlXQFsEtt@amdc1976>
References: <1493315.8NlXQFsEtt@amdc1976>
Message-ID: <e9259b1f-1cd7-b70f-86c3-cbe02c94be22@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Bartlomiej,

On 04/28/2016 10:44 AM, Bartlomiej Zolnierkiewicz wrote:
> Disable big.LITTLE switcher in order to allow automatic usage of
> cpufreq-dt driver on Exynos542x/Exynos5800 SoCs based boards.
> 
> This change should not cause any problems as arm_big_little[_dt]
> driver (which is using big.LITTLE switcher support to do the "real"
> big.LITTLE switching work) is not used on any Exynos SoC based
> board currently.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

On an Exynos5422 Odroid XU4 and Exynos5800 Peach Pi Chromebook:

Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
--
Javier Martinez Canillas
Open Source Group
Samsung Research America
