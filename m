From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sun, 18 Jan 2015 19:28:58 +0100
Subject: [PATCH RESEND] pxa_timer: fix session missmatch warning
In-Reply-To: <1421286860-23296-1-git-send-email-dbaryshkov@gmail.com>
References: <1421286860-23296-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <54BBFB6A.5060104@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/15/2015 02:54 AM, Dmitry Eremin-Solenikov wrote:
> Fix the following warning:
>
> WARNING: drivers/clocksource/built-in.o(.text.unlikely+0x70): Section mismatch in reference from the function pxa_timer_common_init() to the function .init.text:clocksource_mmio_init()
> The function pxa_timer_common_init() references
> the function __init clocksource_mmio_init().
> This is often because pxa_timer_common_init lacks a __init
> annotation or the annotation of clocksource_mmio_init is wrong.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com

Applied to my tree.

Thanks !

   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
