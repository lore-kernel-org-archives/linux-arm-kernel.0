From: tony@atomide.com (Tony Lindgren)
Date: Fri, 14 Sep 2018 06:20:28 -0700
Subject: [PATCH] gpio: omap: Remove custom PM calls and use cpu_pm instead
In-Reply-To: <CACRpkdbjkL=Aq1ktMFT1jwOrOwby5xZgh-GC0JAheR9UU71Ajg@mail.gmail.com>
References: <20180911183729.17110-1-tony@atomide.com>
 <CACRpkdbjkL=Aq1ktMFT1jwOrOwby5xZgh-GC0JAheR9UU71Ajg@mail.gmail.com>
Message-ID: <20180914132028.GM5662@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Linus Walleij <linus.walleij@linaro.org> [180914 09:13]:
> On Tue, Sep 11, 2018 at 8:37 PM Tony Lindgren <tony@atomide.com> wrote:
> 
> > Linus, once people are happy with these, can you maybe set up an
> > immutable branch with both patches in it?
> 
> Sure thing, just awaiting the final ACKed version.

Looks like I need a bit more time though to sort out the suspend/resume
though. And it seems we can now finally drop the pm_runtime_irq_safe too :)

> There are some more OMAP patches floating I see, so maybe
> a branch with all of them on for testing purposes and coordination?

OK sounds good to me thanks.

Tony
