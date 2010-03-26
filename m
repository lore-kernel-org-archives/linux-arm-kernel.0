From: linus.walleij@stericsson.com (Linus WALLEIJ)
Date: Fri, 26 Mar 2010 10:47:19 +0100
Subject: [PATCH 4/5] ARM: add PrimeCell generic DMA to PL011
In-Reply-To: <1269579457.8895.5.camel@bnru03>
References: <1268056365-17417-1-git-send-email-linus.walleij@stericsson.com>
	<b328b2051003252142o1c142ca0h66135eb9129d1c99@mail.gmail.com>
	<1269579457.8895.5.camel@bnru03>
Message-ID: <CEE6BB42CAD6E947908279175AF8470A0391F4B7@EXDCVYMBSTM006.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Srinidhi]

> >
> > +#include <mach/coh901318.h>
> Is this accidentally added? Please update 5983/1 patch in Russell's
> tracking system.

OK I'll update the entire series when I'm finished with porting
it on top of Dan's requested changes to DMAengine.

Russell cannot commit them until the required changes from DMAengine
are in actually, unless I push the PrimeCell DMA API through
Dan's DMA tree.

Linus
