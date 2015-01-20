From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 20 Jan 2015 14:56:42 +0100
Subject: [PATCH] ARM: clocksource: add asm9260_timer driver
In-Reply-To: <1420708042-22906-2-git-send-email-linux@rempel-privat.de>
References: <1417193657-31602-2-git-send-email-linux@rempel-privat.de>
 <1420708042-22906-1-git-send-email-linux@rempel-privat.de>
 <1420708042-22906-2-git-send-email-linux@rempel-privat.de>
Message-ID: <54BE5E9A.8070502@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/2015 10:07 AM, Oleksij Rempel wrote:
> In some cases asm9260 looks similar to iMX2x. One of exceptions is
> timer controller. So this patch introduces new driver for this special case.
>
> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Fixed conflict in the Makefile and applied to my tree.

Thanks !

   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
