From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Nov 2014 13:06:40 +0100
Subject: [PATCH 00/11] ARM: at91: remove !DT support for at91rm9200
In-Reply-To: <20141128113111.GO4508@piout.net>
References: <cover.1417103399.git.nicolas.ferre@atmel.com>
 <2770184.6f6RpLLlMS@wuerfel> <20141128113111.GO4508@piout.net>
Message-ID: <25050514.vKmbVUQfkQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 28 November 2014 12:31:12 Alexandre Belloni wrote:
> On 28/11/2014 at 09:49:10 +0100, Arnd Bergmann wrote :
> > > > Actually, some work was done but we never saw an other version of the
> > > > series. Alexander, are you still interested? Else we can take the patch
> > > > below.
> > > > 
> > > > http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/246679.html
> > 
> > I see. Yes, the approach is similar, and there are actually multiple
> > independent problems:
> > 
> > - getting the current driver to build with multiplatform (trivial, 5 lines)
> > - changing the gpio handling to work with DT (simple, both of us did that)
> > - writing the binding (simple)
> 
> Yeah, let's focus on those first steps. Takashi was willing to take
> patches, even if we were not converting the driver to ASoC.
> 
> > - changing the driver to ASoC (not that simple)
> > 
> > > Well, I tried to get a ac97c driver based on alsa soc framework as suggested 
> > > by Takashi. But I failed so far, I could not get my head around those 
> > > architecture.
> > 
> > Let's just start with the trivial first patch, that can probably just be merged
> > into 3.19, and then we can build on top of that later if anybody wants to
> > get ac97 working again on at91.
> > 
> 
> Do you want one of us to send that patch to Takashi and the Alsa ML or
> will you do it?
> You can add my ack.

Please send it after you have checked that it actually works, I only
took a snippet from my earlier patch assuming it would be sufficient,
but I didn't try.

	Arnd
