From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 29 Mar 2013 16:08:21 +0530
Subject: [PATCH 4/9] ARM: OMAP4: cpuidle: fix wrong driver initialization
In-Reply-To: <1364553095-25110-4-git-send-email-daniel.lezcano@linaro.org>
References: <1364553095-25110-1-git-send-email-daniel.lezcano@linaro.org>
 <1364553095-25110-4-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <51556F1D.5030208@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 March 2013 04:01 PM, Daniel Lezcano wrote:
> The driver is initialized several times. This is wrong and if the
> return code of the function was checked, it will return -EINVAL.
> 
> Move this initialization out of the loop.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
Fix for this is already and v2 of the patch is here [1]

Regards,
Santosh

[1] https://patchwork.kernel.org/patch/2329861/
