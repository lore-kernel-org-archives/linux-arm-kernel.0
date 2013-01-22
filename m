From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Jan 2013 17:47:24 +0000
Subject: [PATCH 15/15] staging/omapdrm: don't build on multiplatform
In-Reply-To: <20130122173013.GA17212@kroah.com>
References: <1358788568-11137-1-git-send-email-arnd@arndb.de>
 <50FEC508.50004@ti.com> <20130122173013.GA17212@kroah.com>
Message-ID: <201301221747.24618.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 January 2013, Greg Kroah-Hartman wrote:
> > Ie. I'd prefer to re-enable omapdss on multi-plat rather than
> > disabling omapdrm.  With changes in drm core, it is a bit of a pain
> > to compile test all the arm drivers by doing N different builds, so
> > we've been trying to get to the point of all arm drm drivers
> > supporting multi-plat
> 
> Ok, I'll let you and Arnd fight it out and drop this patch from my
> to-apply queue for now...

If Rob thinks there is no danger in allowing omap2_dss to be built
on all platforms, and Tomi has no objections, I'm fine with that, too.
In general, that is the right solution, I was just trying to be
conservative for the 3.8 cycle.

	Arnd
