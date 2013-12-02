From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 02 Dec 2013 12:55:47 +0100
Subject: [PATCH/RESEND] clocksource: armada-370-xp: Enable timer divider
 only when needed
In-Reply-To: <1385748290-1178-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1385748290-1178-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <529C7543.2050803@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/29/2013 07:04 PM, Ezequiel Garcia wrote:
> The current code sets the timer divider bits always. However, when
> the 25 MHz timer is enabled, this is not needed and has no effect.
> As this causes some confusion, rework the code so the divider is
> set only when needed, i.e. when the 25 MHz timer is not in use.
>
> Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---

Applied in my tree for 3.14.

Thanks
   -- Daniel



-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
