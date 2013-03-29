From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 29 Mar 2013 17:05:38 +0530
Subject: [PATCH 9/9] ARM: omap3: cpuidle: enable time keeping
In-Reply-To: <1364553095-25110-9-git-send-email-daniel.lezcano@linaro.org>
References: <1364553095-25110-1-git-send-email-daniel.lezcano@linaro.org>
 <1364553095-25110-9-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <51557C8A.4060607@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 March 2013 04:01 PM, Daniel Lezcano wrote:
> The TIME_VALID flag is specified for the different states but
> the time residency computation is not done, no tk flag, no time
> computation in the idle function.
> 
> Set the en_core_tk_irqen flag to activate it.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
