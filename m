From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 20 Oct 2015 12:30:53 +0200
Subject: [PATCH v2 5/6] ARM: exynos: select POWER_RESET_SYSCON and
 POWER_RESET_SYSCON_POWEROFF
In-Reply-To: <1445333085-22837-6-git-send-email-alim.akhtar@samsung.com>
References: <1445333085-22837-1-git-send-email-alim.akhtar@samsung.com>
 <1445333085-22837-6-git-send-email-alim.akhtar@samsung.com>
Message-ID: <562617DD.1010403@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Alim,

On 10/20/2015 11:24 AM, Alim Akhtar wrote:
> Since we switch to use generic syscon regmap based reset/poweroff
> driver for exynos SoC, lets select it from ARCH_EXYNOS instead of
> enabling it from various defconfigs. This also select POWER_RESET
> as SYSCON-{reset, poweroff} drivers depends on it.
> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
> 

Patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
