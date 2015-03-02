From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 02 Mar 2015 22:39:21 +0100
Subject: [PATCH 0/5] ARM: orion5k/mv78xx0/dove multiplatform support
In-Reply-To: <20150302213058.GB2375@lunn.ch>
References: <1425328618-894030-1-git-send-email-arnd@arndb.de>
 <20150302213058.GB2375@lunn.ch>
Message-ID: <2171351.v0ZP8NQ0Dy@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 March 2015 22:30:58 Andrew Lunn wrote:
> On Mon, Mar 02, 2015 at 09:36:53PM +0100, Arnd Bergmann wrote:
> > Hi everyone,
> 
> Hi Arnd
> 
> Dove already is multi-platform, when you use it in mach-mvebu.  The
> old mach-dove is there to slowly bit rot, because there is one user
> who has a lot of out of tree patches which are apparently not easy to
> make work with DT mach-mvebu Dove code.

I understand that, but I really want to finalize this chapter
of the multiplatform work, it's been going for too long. It's
not the only platform that has ATAG-based board files remaining,
and I don't see how keeping it the remaining dove board files
out of multiplatform is going to speed up their removal.

> > I'm trying to get all ARMv7 platforms moved over to
> > ARCH_MULTIPLATFORM
> 
> It should be noted that orion5x is not an ARMv7.

mv78xx0 as well. Yes, that would have been good to mention
in the cover-letter, I assumed that everyone was aware of that.

It would seem a bit silly to do one or two of these and not
do the others at the same time.

	Arnd
