From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 29 Mar 2016 16:39:13 +0200
Subject: [PATCH v4 9/9] clocksource: arm_arch_timer: Remove
 arch_timer_get_timecounter
In-Reply-To: <1458842023-31853-10-git-send-email-julien.grall@arm.com>
References: <1458842023-31853-1-git-send-email-julien.grall@arm.com>
 <1458842023-31853-10-git-send-email-julien.grall@arm.com>
Message-ID: <56FA9391.1040007@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/24/2016 06:53 PM, Julien Grall wrote:
> The only call of arch_timer_get_timecounter (in KVM) has been removed.
>
> Signed-off-by: Julien Grall <julien.grall@arm.com>
> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>

Hi Julien,

do you want me to take this patch through my tree ?

   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
