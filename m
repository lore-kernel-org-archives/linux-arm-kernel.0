From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 06 Jul 2015 10:46:09 +0200
Subject: [PATCH v2] clocksource: dw_apb_timer: add dynamic irq flag to
 the timer
In-Reply-To: <1435986403-3797-1-git-send-email-jszhang@marvell.com>
References: <1435986403-3797-1-git-send-email-jszhang@marvell.com>
Message-ID: <559A4051.8000101@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/04/2015 07:06 AM, Jisheng Zhang wrote:
> Commit d2348fb6fdc6 ("tick: Dynamically set broadcast irq affinity")
> adds one execllent feature CLOCK_EVT_FEAT_DYNIRQ to let the core set the
> interrupt affinity of the broadcast interrupt to the cpu which has the
> earliest expiry time. This patch adds CLOCK_EVT_FEAT_DYNIRQ flag to
> avoid unnecessary wakeups and IPIs when the dw_apb_timer is used as
> broadcast timer.

Thanks for the measurements. I picked the patch but did not applied it 
yet since I will have to handle a trivial conflict with the recent changes.

   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
