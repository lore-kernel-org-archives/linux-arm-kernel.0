From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 16 Jun 2016 15:23:40 +0200
Subject: [RFC PATCH 02/15] clocksource: samsung_pwm_timer: fix endian
 accessors
In-Reply-To: <20160608183110.13851-3-matthew@mattleach.net>
References: <20160608183110.13851-1-matthew@mattleach.net>
 <20160608183110.13851-3-matthew@mattleach.net>
Message-ID: <5762A85C.6040700@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/08/2016 08:30 PM, Matthew Leach wrote:
> Fix the Samsung pwm timer access code to deal with kernels built for big
> endian operation.
>
> Signed-off-by: Matthew Leach <matthew@mattleach.net>
> ---
> CC: Daniel Lezcano <daniel.lezcano@linaro.org>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: linux-kernel at vger.kernel.org
> ---

I will pick this patch in my tree.

Thanks.

   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
