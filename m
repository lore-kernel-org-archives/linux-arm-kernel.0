From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 31 Jan 2012 09:21:20 +0200
Subject: [PATCH 0/2] ARM: OMAP2+: PM: miscellaneous powerdomain-related
 improvements
In-Reply-To: <871uqgswy8.fsf@ti.com>
References: <20120130093931.11027.31048.stgit@dusk>  <871uqgswy8.fsf@ti.com>
Message-ID: <1327994480.4102.44.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-01-30 at 13:27 -0800, Kevin Hilman wrote:
> Paul Walmsley <paul@pwsan.com> writes:
> 
> > This series optimizes some of the powerdomain-related code in
> > arch/arm/mach-omap2/pm*, and fixes a bug or two.  These were noticed while
> > working on the functional powerstate code.
> >
> > Rajendra and Santosh, if you have a spare moment, could you please
> > peek at the OMAP4 LOWPOWERSTATECHANGE part of the second patch?  It
> > makes sense to me in theory, but you both would probably know better
> > than I :-)
> >
> > Kevin, want to take this series (assuming folks are happy with it) ?
> 
> Yes, I'll take this and add the Ack from Santosh.  Thanks for the nice
> cleanup.   
> 
> Will submit after seeing a Tested-by from someone who can test with CORE
> retention/off on OMAP4 (hint, hint,  Tero :)

Yeah, I can test these out hopefully tomorrow / today, I am busy today
creating a release but lets see. :) The patches seem okay to me also at
least.

-Tero
