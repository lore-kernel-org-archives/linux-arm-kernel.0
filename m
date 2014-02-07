From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 7 Feb 2014 09:07:49 +0100
Subject: [PATCH v2 1/2] at91: gpio: use gpiolib API to mark a GPIO used
 as an IRQ
In-Reply-To: <52EB657A.4040601@atmel.com>
References: <1390473478-5591-1-git-send-email-jjhiblot@traphandler.com>
 <1390473478-5591-2-git-send-email-jjhiblot@traphandler.com>
 <CACRpkdZ4LxkRERfD-prZvJSOZyomgf8v8P+vLhb_+hrSkL8rzg@mail.gmail.com>
 <52EB657A.4040601@atmel.com>
Message-ID: <20140207080749.GS9558@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09:57 Fri 31 Jan     , Nicolas Ferre wrote:
> On 31/01/2014 08:55, Linus Walleij :
> > On Thu, Jan 23, 2014 at 11:37 AM, Jean-Jacques Hiblot
> > <jjhiblot@traphandler.com> wrote:
> > 
> >> When an IRQ is started on a GPIO line, mark this GPIO as IRQ in
> >> the gpiolib so we can keep track of the usage centrally.
> >>
> >> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> > 
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > 
> > Nicolas, are you queueing this patch?
> 
> Yes, I will.
> 
> > I guess this custom GPIO implementation is going away with
> > the transition to pinctrl else I'd requested that it be moved to
> > drivers/gpio...
> 
> Absolutely. But I suspect it will still be around for some time...
moved no

I'm not even sure we need to update it at all to simply for the switch to DT

nearly all the support for old SoC is here so I see no reason to do not switch
I even a big patch serie to switch old board to DT

So for me no do not touch the old stuff

Best Regards,
J.
> 
> Thanks for your review. Bye,
> -- 
> Nicolas Ferre
