From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 20 Feb 2017 21:50:09 +0100
Subject: [PATCH v2 1/3] mtd: nand: Cleanup/rework the atmel_nand driver
In-Reply-To: <20170220213803.7ba5591e@bbrezillon>
References: <1487593718-20752-1-git-send-email-boris.brezillon@free-electrons.com>
 <1487593718-20752-2-git-send-email-boris.brezillon@free-electrons.com>
 <CAHp75VdwQGP-qa0c0KQwrdpZmCGc3RuEsJ-E-XLbBzQSn4Yxcg@mail.gmail.com>
 <20170220213803.7ba5591e@bbrezillon>
Message-ID: <20170220215009.0ecbf5a1@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 Feb 2017 21:38:03 +0100
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> On Mon, 20 Feb 2017 22:27:17 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
> > On Mon, Feb 20, 2017 at 2:28 PM, Boris Brezillon
> > <boris.brezillon@free-electrons.com> wrote:
> >   
> > >  drivers/mtd/nand/atmel/nand-controller.c | 2269 +++++++++++++++++++++++++++
> > >  drivers/mtd/nand/atmel_nand.c            | 2479 ------------------------------    
> > 
> > Does -M -C help you?
> > At least it would help reviewers
> >   
> 
> No it doesn't, because files were not just moved around using git mv,
> it's a complete rewrite of the driver. IIUC, you're about to review
> this submission, or are you just trolling like last time?

My bad, I mistaken you with someone else. Sorry for being harsh, but my
explanation stands ;-).
