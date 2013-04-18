From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 18 Apr 2013 14:00:32 +0530
Subject: [V3 patch 02/19] ARM: shmobile: cpuidle: remove shmobile_enter_wfi
 prototype
In-Reply-To: <1365770165-27096-3-git-send-email-daniel.lezcano@linaro.org>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
 <1365770165-27096-3-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <516FAF28.80002@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 12 April 2013 06:05 PM, Daniel Lezcano wrote:
> Commit 688036b538974de32ce55be8b0e013b003992abc removed the function
> 'shmobile_enter_wfi' but we forgot to remove the definition in the header file.
> 
> Note this function is just an alias to 'cpu_do_idle()' wrapped into a cpuidle
> function callback prototype which already exists with the default WFI state
> and the arm_simple_enter function.
> 
> Remove the function prototype.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
You can actually fold this into 1/19. No strong opinion though.
