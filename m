From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 02 Dec 2015 22:15:02 +0100
Subject: [PATCH 0/5] ARM: orion5x/dove/mv78xx0 multiplatform
In-Reply-To: <20151202203810.GH9866@lunn.ch>
References: <1448466557-435335-1-git-send-email-arnd@arndb.de>
 <20151202202240.GH8644@n2100.arm.linux.org.uk>
 <20151202203810.GH9866@lunn.ch>
Message-ID: <10084728.p75H39SaXO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 December 2015 21:38:10 Andrew Lunn wrote:
> On Wed, Dec 02, 2015 at 08:22:40PM +0000, Russell King - ARM Linux wrote:
> > On Wed, Dec 02, 2015 at 08:51:04PM +0100, Arnd Bergmann wrote:
> > > I'm mostly interested in it because it's the only ARMv7 platform that is
> > > left after my other patches, and I just want to be done with it after
> > > spending 5 years on it 
> > 
> > My understanding is that the long term goal is to delete mach-dove once
> > everyone has settled down into the mvebu DT world.
> > 
> > Right now we have mvebu which covers Dove using DT.  We have mach-dove
> > which is legacy non-DT Dove.
> > 
> > It seems to me to be completely crazy to want to bring legacy code, which
> > is ultimately destined to be deleted, into multiplatform.
> 
> I agree. We have multiplatform dove already, it is in mach-mvebu. Do
> we really need both mach-dove and mach-mvebu dove in one kernel?

I'm also fine with deleting mach-dove, but that would be much more
disruptive to Russell's work, so I don't think that helps anyone.

I've rebased the series to leave out the last two patches for dove,
and added the watchdog on dove, so I can at least get the other
patches out of my queue if that works for now.

	Arnd
