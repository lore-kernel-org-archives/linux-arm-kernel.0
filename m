From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 11 Feb 2014 13:58:27 +0100
Subject: [PATCH v6 2/3] clocksource: keystone: add bindings for keystone
 timer
In-Reply-To: <1392027058-11680-3-git-send-email-ivan.khoronzhuk@ti.com>
References: <1392027058-11680-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1392027058-11680-3-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <52FA1E73.7050200@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/2014 11:10 AM, Ivan Khoronzhuk wrote:
> This patch provides bindings for the 64-bit timer in the KeyStone
> architecture devices. The timer can be configured as a general-purpose 64-bit
> timer, dual general-purpose 32-bit timers. When configured as dual 32-bit
> timers, each half can operate in conjunction (chain mode) or independently
> (unchained mode) of each other.
>
> It is global timer is a free running up-counter and can generate interrupt
> when the counter reaches preset counter values.
>
> Documentation:
> http://www.ti.com/lit/ug/sprugv5a/sprugv5a.pdf
>
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
> ---

Applied to my tree for 3.15

Thanks !

   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
