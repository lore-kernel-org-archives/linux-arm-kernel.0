From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 12 Nov 2012 13:15:06 -0800
Subject: [PATCH] clk: spear: Add stub functions for
 spear3[0|1|2]0_clk_init()
In-Reply-To: <CAOh2x==ng3A66P=Vx+-C791LTGCS1fWVpMfUKDorU5G=ZXrjLQ@mail.gmail.com>
References: <1352169260.2625.4.camel@phoenix>
 <CAOh2x==ng3A66P=Vx+-C791LTGCS1fWVpMfUKDorU5G=ZXrjLQ@mail.gmail.com>
Message-ID: <20121112211506.20034.67807@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting viresh kumar (2012-11-05 19:36:18)
> On Tue, Nov 6, 2012 at 8:04 AM, Axel Lin <axel.lin@ingics.com> wrote:
> > This fixes compile error if one of SPEAr3xx implementations is not selected.
> >
> >   CC      drivers/clk/spear/spear3xx_clock.o
> > drivers/clk/spear/spear3xx_clock.c: In function 'spear3xx_clk_init':
> > drivers/clk/spear/spear3xx_clock.c:599:3: error: implicit declaration of function 'spear300_clk_init' [-Werror=implicit-function-declaration]
> > drivers/clk/spear/spear3xx_clock.c:601:3: error: implicit declaration of function 'spear310_clk_init' [-Werror=implicit-function-declaration]
> > drivers/clk/spear/spear3xx_clock.c:603:3: error: implicit declaration of function 'spear320_clk_init' [-Werror=implicit-function-declaration]
> > cc1: some warnings being treated as errors
> > make[3]: *** [drivers/clk/spear/spear3xx_clock.o] Error 1
> > make[2]: *** [drivers/clk/spear] Error 2
> > make[1]: *** [drivers/clk] Error 2
> > make: *** [drivers] Error 2
> >
> > Signed-off-by: Axel Lin <axel.lin@ingics.com>
> 
> Thanks..
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Taken into clk-next.

Thanks,
Mike
