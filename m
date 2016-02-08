From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 8 Feb 2016 14:33:04 +0100
Subject: [PATCH v1] clocksource: atmel-pit: register as a sched_clock
In-Reply-To: <1454606493-15094-1-git-send-email-romain.izard.pro@gmail.com>
References: <1454606493-15094-1-git-send-email-romain.izard.pro@gmail.com>
Message-ID: <56B89910.3060305@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/04/2016 06:21 PM, Romain Izard wrote:
> Register the counter of the Periodic Interval Timer as a possible source
> for sched_clock. This provides a better precision than the jiffies-based
> default.
>
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>

Nicolas, Boris,

Are you ok with this patch ?

[ ... ]

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
