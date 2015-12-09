From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 9 Dec 2015 10:13:42 -0300
Subject: [PATCH v4 0/8] cpufreq: add generic cpufreq driver support for
 Exynos542x/5800 platforms
In-Reply-To: <1449512300-17230-1-git-send-email-b.zolnierkie@samsung.com>
References: <1449512300-17230-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <56682906.50607@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Bartlomiej,

On 12/07/2015 03:18 PM, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> This patch series adds generic cpufreq-dt driver support for
> Exynos542x/5800 (using the new CPU clock type which allows it).
> 
> It has been tested on Exynos5422 based ODROID-XU3 Lite board.
>

I tested on an Exynos5800 Peach Pi and all governors are working
as expected on both the Cortex-A7 and Cortex-A15 cores.

So for the whole series:

Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
