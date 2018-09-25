From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 25 Sep 2018 08:53:01 +0200
Subject: [PATCHv2 0/3] omap gpio add level idle,
 cpu_pm and drop runtime_irq_safe
In-Reply-To: <20180920193532.7714-1-tony@atomide.com>
References: <20180920193532.7714-1-tony@atomide.com>
Message-ID: <CACRpkdao5j14OXAvL==008gnquvKpzuPwkK+vA2jTeyy9H+gcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2018 at 9:35 PM Tony Lindgren <tony@atomide.com> wrote:

> Linus, assuming people are happy with these, I'd appreciate an immutable branch
> with these in case we run into merge conflicts for arch/arm/mach-omap2 changes.

I created an immutable branch named "ib-omap" yesterday:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/log/?h=ib-omap

It passed build tests this morning so I merged this into my "devel" branch
for next.

Yours,
Linus Walleij
