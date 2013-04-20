From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 20 Apr 2013 15:19:43 +0200
Subject: [PATCH 1/4] clocksource: nomadik-mtu: fix up clocksource/timer
In-Reply-To: <1366463287-9922-1-git-send-email-linus.walleij@linaro.org>
References: <1366463287-9922-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CACRpkdYWSM0BK77qWbQWh0xsN+Ps95Q70zG-GE98MYvThrky2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM SoC folks:

On Sat, Apr 20, 2013 at 3:08 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> The Nomadik clocksource driver has had a bad define making it
> impossible to use it for sched_clock() for a while. Fix this
> and also enable it for the Nomadik.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

This one should go to fixes ASAP, could you pick it to your fixes
branch? It could be tagged stable if desired - this only affects the
Nomadik which works just OK on jiffies so it's really no big regression.
The Ux500 does not use the MTU for sched_clock().

Yours,
Linus Walleij
