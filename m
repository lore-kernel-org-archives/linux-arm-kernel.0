From: tony@atomide.com (Tony Lindgren)
Date: Fri, 11 Oct 2013 10:23:38 -0700
Subject: [PATCH] pinctrl: single: call pcs_soc->rearm() whenever IRQ
 mask is changed
In-Reply-To: <CACRpkdb7iUypffB7O7-RhQhVf5WkjYdVCNLRz=BgySG4FET-xQ@mail.gmail.com>
References: <1381507996-15021-1-git-send-email-rogerq@ti.com>
 <CACRpkdb7iUypffB7O7-RhQhVf5WkjYdVCNLRz=BgySG4FET-xQ@mail.gmail.com>
Message-ID: <20131011172337.GU29913@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Linus Walleij <linus.walleij@linaro.org> [131011 09:27]:
> On Fri, Oct 11, 2013 at 6:13 PM, Roger Quadros <rogerq@ti.com> wrote:
> 
> > On OMAPs the IO ring must be rearmed each time the pad wakeup
> > configuration is changed. So call pcs_soc->rearm() from
> > pcs_irq_set().
> >
> > Signed-off-by: Roger Quadros <rogerq@ti.com>
> 
> If Tony needs to apply this with the other patches: Acked-by.

Just replied with a slightly modified version of Roger's patch
suggesting you pull in the signed tag I posted for you yesterday
and then you can pick up Roger's fix into the pinctrl tree :)

Tony
