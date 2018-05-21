From: jmkrzyszt@gmail.com (Janusz Krzysztofik)
Date: Mon, 21 May 2018 20:10:44 +0200
Subject: [PATCH 1/6] ARM: OMAP1: ams-delta: add GPIO lookup tables
In-Reply-To: <20180521173519.GA98604@atomide.com>
References: <20180518210954.29044-1-jmkrzyszt@gmail.com>
 <20180521173519.GA98604@atomide.com>
Message-ID: <2148445.bqG5QPj1MO@z50>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, May 21, 2018 7:35:19 PM CEST Tony Lindgren wrote:
> Hi,
> 
> * Janusz Krzysztofik <jmkrzyszt@gmail.com> [180518 14:12]:
> > Scope of the change is limited to GPIO pins used by board specific
> > device drivers which will be updated by follow-up patches of the
> > series. Those are some OMAP GPIO (gpio-0-15) and most of Amstrad Delta
> > latch2 GPIO bank pins. Remaining pins of those banks, as well as
> > Amstrad Delta latch1 pins, will be addressed later.
> > 
> > Assign a label ("latch2") to the bank, enumerate its pins and put that
> > information, together with OMAP GPIO bank pins, in GPIO lookup tables.
> > Assign lookup tables to devices as soon as those devices are registered
> > and their names can be obtained.
> > 
> > A step froward in:
> > - removal of hard-coded GPIO numbers from drivers,
> > - removal of board mach includes from drivers,
> > - switching to dynamically assigned GPIO numbers.
> 
> Is this first patch safe for me to apply separately?

Absolutely, it is.

Thanks,
Janusz
