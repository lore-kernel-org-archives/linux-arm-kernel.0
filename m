From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 12 Jun 2013 11:46:37 +0200
Subject: [PATCH v2 0/4] dw_apb_timer: osc as sched_clock, clocks and
 clocksource_of support
In-Reply-To: <201306121055.53685.heiko@sntech.de>
References: <201306041136.09566.heiko@sntech.de>
 <201306121055.53685.heiko@sntech.de>
Message-ID: <CACRpkdZmDWTy=U_rhU9uVXy9N5jEOk6qQingiO5kb+Kc2WkL3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 12, 2013 at 10:55 AM, Heiko St?bner <heiko@sntech.de> wrote:

> with clocksource_of conversion of picoxcell and socfpga, this series stands on
> its own. Is anybody going to pick it up?

I would suggest you send a pull request to the ARM SoC maintainers.
This is where most clocksource code and refactorings related to
ARM things come in.

Yours,
Linus Walleij
