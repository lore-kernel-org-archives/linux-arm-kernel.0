From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 15 Jul 2016 07:43:30 -0400
Subject: [PATCH] ARM: exynos_defconfig: Enable bus frequency scaling with
 DEVFREQ/DEVFREQ-Event
In-Reply-To: <1468546426-4482-1-git-send-email-cw00.choi@samsung.com>
References: <1468546426-4482-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <06e7eb98-fc61-df71-d387-6fa105957bb9@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Chanwoo,

On 07/14/2016 09:33 PM, Chanwoo Choi wrote:
> This patch enables the bus frequency scaling driver with DEVFREQ and
> DEVFREQ-Event framework. This patches already was merged for Odroid-U3/XU3
> ,Trats2 and Rinato/Monk boards.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---

The patch makes sense to me. Should we do the same for multi_v7_defconfig?

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
