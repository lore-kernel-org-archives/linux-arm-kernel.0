From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 16 Aug 2012 19:38:44 +0200
Subject: [PATCH 13/14] arm: at91: dt: at91sam9 add nand pinctrl support
In-Reply-To: <CACQ1gAhWdwrXEkicy4ij=rukzS-v98bZRr433Qq5M_Dan5JAog@mail.gmail.com>
References: <20120810124820.GA20557@game.jcrosoft.org>
 <1344603731-32667-1-git-send-email-plagnioj@jcrosoft.com>
 <1344603731-32667-13-git-send-email-plagnioj@jcrosoft.com>
 <CACRpkdZXjFE7UsRneskNqnN7DFERHxgAt-FCXtL2A52xKgEA=w@mail.gmail.com>
 <CACQ1gAhWdwrXEkicy4ij=rukzS-v98bZRr433Qq5M_Dan5JAog@mail.gmail.com>
Message-ID: <20120816173844.GC7439@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:19 Thu 16 Aug     , Richard Genoud wrote:
> 2012/8/15 Linus Walleij <linus.walleij@linaro.org>:
> > On Fri, Aug 10, 2012 at 3:02 PM, Jean-Christophe PLAGNIOL-VILLARD
> > <plagnioj@jcrosoft.com> wrote:
> >
> >> Cc: Linus Walleij <linus.walleij@linaro.org>
> >> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> >> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > (...)
> >> +                               nand {
> >> +                                       pinctrl_nand: nand-0 {
> >> +                                               atmel,pins =
> >> +                                                       <2 13 0x0 0x1   /* PC13 gpio RDY pin pull_up */
> >> +                                                        2 14 0x0 0x1>; /* PC14 gpio enable pin pull_up */
> >> +                                       };
> >> +                               };
> >
> > Again magic hex I don't understand so skipping this patch -> Nicolas.
> 
> Maybe it will be more readable if we use something like :
> atmel,pull-up;
> atmel,multidrive;
> atmel,mux="GPIO"
> atmel,mux="A"
> ...
> just my 2 cents...
no too much data and too much node as you will need a node per pin which we
tyr to avoid

Best Regards,
J.
