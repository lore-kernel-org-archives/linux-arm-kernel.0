From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 18 Apr 2013 13:58:30 +0530
Subject: [V3 patch 01/19] ARM: shmobile: cpuidle: remove shmobile_enter_wfi
 function
In-Reply-To: <1365770165-27096-2-git-send-email-daniel.lezcano@linaro.org>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
 <1365770165-27096-2-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <516FAEAE.1060201@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 12 April 2013 06:05 PM, Daniel Lezcano wrote:
> Remove the shmobile_enter_wfi function which is the same as the
> common WFI enter function from the arm cpuidle driver defined
> with the ARM_CPUIDLE_WFI_STATE macro.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
