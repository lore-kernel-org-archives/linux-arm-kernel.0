From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 04 Oct 2011 21:29:36 +0200
Subject: [PATCH 26/30] ARM: omap: add board autoselection
In-Reply-To: <20111004155752.GT6324@atomide.com>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<201110040944.13205.arnd@arndb.de>
	<20111004155752.GT6324@atomide.com>
Message-ID: <2340307.S2RzXdHlIz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 04 October 2011 08:57:52 Tony Lindgren wrote:
> * Arnd Bergmann <arnd@arndb.de> [111004 00:10]:
> > On Monday 03 October 2011, Tony Lindgren wrote:
> >
> > > Yes please leave out the list so we don't need to constantly update it.
> > > Let's just always build in MACH_OMAP_GENERIC.
> > 
> > That's what I had initially, but now that board file has become
> > omap2-specific and no longer works on omap3-only or omap4-only
> > configurations.
> 
> Will send a pull request for basic DT bootstrap support from Benoit
> that fixes that. So maybe let's sort that out first, then always
> select it?

Yes, sounds good. That is certainly the better solution in the long run.

	Arnd
