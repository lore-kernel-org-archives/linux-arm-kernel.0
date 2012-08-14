From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Aug 2012 10:29:14 +0200
Subject: [PATCH 5/8] mfd: Provide the PRCMU with its own IRQ domain
In-Reply-To: <1344527635-6163-6-git-send-email-lee.jones@linaro.org>
References: <1344527635-6163-1-git-send-email-lee.jones@linaro.org>
 <1344527635-6163-6-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZ7bMBytyDppV2sB1d1sUbDpPRqAQVOq8k4UOYdmg+Mkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 9, 2012 at 5:53 PM, Lee Jones <lee.jones@linaro.org> wrote:

> +static struct irq_domain *db8500_irq_domain;

So this is a good idea.

> +int db8500_irq_get_virq(int irq);

And I'm sceptic about this business. Why isn't this physical-to virtual
mapping business confined to the core MFD driver? But enlighten me.

Yours,
Linus Walleij
