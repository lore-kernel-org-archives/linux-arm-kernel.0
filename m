From: alexanders83@web.de (Alexander Stein)
Date: Fri, 28 Nov 2014 09:27:38 +0100
Subject: [PATCH 00/11] ARM: at91: remove !DT support for at91rm9200
In-Reply-To: <20141128002822.GM4508@piout.net>
References: <cover.1417103399.git.nicolas.ferre@atmel.com>
 <3935244.Dm2HkZj2Bg@wuerfel> <20141128002822.GM4508@piout.net>
Message-ID: <1422574.pPO36BQRH8@kongar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

On Friday 28 November 2014, 01:28:22 wrote Alexandre Belloni:
> > >  - sound/atmel/ac97c.c (that one is still not converted to DT anyway...)
> > 
> > This one seems fairly straightforward to do, including a DT binding,
> > but the result is still ugly as it supports the at32 chips that
> > do things very differently.
> > 
> > The patch below gets it to compile and should be enough as a replacement
> > once a compatible string gets added.
> > 
> 
> Actually, some work was done but we never saw an other version of the
> series. Alexander, are you still interested? Else we can take the patch
> below.
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/246679.html

Well, I tried to get a ac97c driver based on alsa soc framework as suggested 
by Takashi. But I failed so far, I could not get my head around those 
architecture.
When keeping my DT support on the current driver, the only thing which is open 
that the bindings should be modifed that they are like soc-ac97link bindings.
I could work on that, but I currently don't know when I can get access again 
to that hardware for testing.

Best regards,
Alexander
