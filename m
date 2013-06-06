From: alior@marvell.com (Lior Amsalem)
Date: Thu, 6 Jun 2013 10:46:48 +0300
Subject: [PATCH 3/3] ARM PJ4B: Add support for errata 4611
In-Reply-To: <10384353.qafBWKgARt@wuerfel>
References: <1369822618-26797-1-git-send-email-gregory.clement@free-electrons.com>
 <2479964.1Q22eHuH4J@wuerfel>
 <EE71107DF0D1F24FA2D95041E64AB9E801A56CF1A8AB@IL-MB01.marvell.com>
 <10384353.qafBWKgARt@wuerfel>
Message-ID: <EE71107DF0D1F24FA2D95041E64AB9E801A56CF1AEF6@IL-MB01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Tuesday, June 04, 2013 2:40 PM
> 
> On Tuesday 04 June 2013 14:34:53 Lior Amsalem wrote:
> > > From: Arnd Bergmann [mailto:arnd at arndb.de]
> > > Sent: Wednesday, May 29, 2013 4:33 PM
> > >
> > > On Wednesday 29 May 2013 15:27:31 Gregory CLEMENT wrote:
> > > > OK I will see what kind of information I can gather and which ones
> > > > I can add to the Documentation/arm/Marvell/README file.
> > > >
> > > > My current understanding is that there are at least 3 kind of CPU:
> > > > PJ4, PJ4B and PJ4B-MP and all of them belongs to the Sheeva family.
> > >
> > > Ok. So I guess PJ4B adds LPAE support, and PJ4B-MP adds SMP support,
> > > right? Do either of them support hypervisor mode?
> >
> > It goes like this:
> > PJ4B: improved version of PJ4.
> > PJ4B-MP: adds LPAE and SMP.
> > No support for virtualization on any.
> 
> Ah, interesting. So PJ4B is just faster than PJ4 and has no extra instructions or
> other features?

It's a different microarchitecture, pipeline, but I don't know all the details.

> 
> > > Regarding the errata: are those needed for production-level chips,
> > > or just for prototypes?
> >
> > These are production level chips.
> 
> Ok, thanks for the information. To clarify, does that mean that all future PJ4B
> and PJ4B-MP based chips also need the errata, or is there is a chance they
> will be fixed in future revisions?

No, to my knowledge they're not going to be fixed.

> 
> 	Arnd

Regards,
Lior Amsalem
