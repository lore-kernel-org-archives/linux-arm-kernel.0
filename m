From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 10 Feb 2013 16:01:54 +0100
Subject: [PATCH 11/14] ARM: ux500: remove irq_base property from
 platform_data
In-Reply-To: <20130210024141.GE25302@quad.lixom.net>
References: <1360093715-6348-1-git-send-email-linus.walleij@stericsson.com>
 <1360093715-6348-12-git-send-email-linus.walleij@stericsson.com>
 <20130210024141.GE25302@quad.lixom.net>
Message-ID: <CACRpkdYfG35UUGZZ=N4GQEkEEV_xEK9dhrz3YQ+kS7DaOSOjGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 10, 2013 at 3:42 AM, Olof Johansson <olof@lixom.net> wrote:

> This patch on its own doesn't apply cleanly at all to arm-soc, I'm guessing
> because I need the rest of the series. With the presumption that you're not
> going to cause grief from sfr due to excessive conflicts. I.e. please try
> merging with arm-soc for-next to see how bad it is:

OK, there were bad conflicts with two device tree patches.

So I'm going to take that stuff out and funnel through ARM SoC
instead.

I have a number of DT patches from Lee on a queues pull request
anyway, so I'll just stack these on top of that and then hopefully things
will fix themselves up.

> patch 11-14:
> Acked-by: Olof Johansson <olof@lixom.net>

Thanks, I took only 11, 12 into the pinctrl tree. It's better off
like this.

Yours,
Linus Walleij
