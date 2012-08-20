From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 20 Aug 2012 10:36:40 +0100
Subject: [PATCH 5/8] mfd: Provide the PRCMU with its own IRQ domain
In-Reply-To: <CACRpkdZ7bMBytyDppV2sB1d1sUbDpPRqAQVOq8k4UOYdmg+Mkw@mail.gmail.com>
References: <1344527635-6163-1-git-send-email-lee.jones@linaro.org>
 <1344527635-6163-6-git-send-email-lee.jones@linaro.org>
 <CACRpkdZ7bMBytyDppV2sB1d1sUbDpPRqAQVOq8k4UOYdmg+Mkw@mail.gmail.com>
Message-ID: <20120820093638.GK8450@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 14, 2012 at 10:29:14AM +0200, Linus Walleij wrote:
> On Thu, Aug 9, 2012 at 5:53 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > +static struct irq_domain *db8500_irq_domain;
> 
> So this is a good idea.

Did you mean this, or did you mean that it's _not_ a good idea?

If the latter is true, where would you prefer to see it?

> > +int db8500_irq_get_virq(int irq);
> 
> And I'm sceptic about this business. Why isn't this physical-to virtual
> mapping business confined to the core MFD driver? But enlighten me.
> 
> Yours,
> Linus Walleij

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
