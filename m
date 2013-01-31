From: grinberg@compulab.co.il (Igor Grinberg)
Date: Thu, 31 Jan 2013 11:09:45 +0200
Subject: [PATCH 4/5] ARM: OMAP2+: Simplify system timers definitions
In-Reply-To: <1359565471-30721-5-git-send-email-jon-hunter@ti.com>
References: <1359565471-30721-1-git-send-email-jon-hunter@ti.com>
 <1359565471-30721-5-git-send-email-jon-hunter@ti.com>
Message-ID: <510A34D9.1000407@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/30/13 19:04, Jon Hunter wrote:
> There is a lot of redundancy in the definitions for the various system
> timers for OMAP2+ devices. For example, the omap3_am33xx_gptimer_timer_init()
> function is the same as the omap3_gp_gptimer_timer_init() function and the
> function omap2_sync32k_timer_init() can be re-used for OMAP4/5 devices.
> Therefore, consolidate the definitions to simplify the code.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

Acked-by: Igor Grinberg <grinberg@compulab.co.il>


-- 
Regards,
Igor.
