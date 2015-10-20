From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 20 Oct 2015 12:31:48 +0200
Subject: [PATCH v2 6/6] ARM: EXYNOS: Remove code for restart and poweroff
 for exynos SoCs
In-Reply-To: <1445333085-22837-7-git-send-email-alim.akhtar@samsung.com>
References: <1445333085-22837-1-git-send-email-alim.akhtar@samsung.com>
 <1445333085-22837-7-git-send-email-alim.akhtar@samsung.com>
Message-ID: <56261814.3050403@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Alim,

On 10/20/2015 11:24 AM, Alim Akhtar wrote:
> Now we can use the generic syscon-{reboot/poweroff} drivers,
> so we don't need special handling for reboot/poweroff in
> exynos pmu driver. This patch remove the same.
> 
> Note: This will break reboot/poweroff on boards with older dtbs
> with a newer kernel.
> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Acked-by: Moritz Fischer <moritz.fischer@ettus.com>
> ---
>  arch/arm/mach-exynos/pmu.c |   43 -------------------------------------------
>  1 file changed, 43 deletions(-)
> 

Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
