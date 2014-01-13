From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 13 Jan 2014 09:27:49 +0100
Subject: [GIT PULL] clockevents/clocksource : new material for 3.14
In-Reply-To: <20140112163318.GA21054@gmail.com>
References: <52C1479E.80808@linaro.org> <20140112163318.GA21054@gmail.com>
Message-ID: <52D3A385.8060504@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/12/2014 05:33 PM, Ingo Molnar wrote:

[ ... ]

> Pulled into tip:timers/core, thanks Daniel!
>
> Note that there was a conflict in drivers/clocksource/clksrc-of.c,
> caused by interaction with this commit:
>
>    4c4b053235fa clocksource: clksrc-of: Do not drop unheld reference on device node
>
> I've resolved it, but please double check the end result once I've
> pushed it all out.

Done. The resolution is ok.

Thanks !
   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
