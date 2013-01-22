From: rob@ti.com (Rob Clark)
Date: Tue, 22 Jan 2013 12:16:11 -0600
Subject: [PATCH 15/15] staging/omapdrm: don't build on multiplatform
In-Reply-To: <201301221747.24618.arnd@arndb.de>
References: <1358788568-11137-1-git-send-email-arnd@arndb.de>
 <50FEC508.50004@ti.com> <20130122173013.GA17212@kroah.com>
 <201301221747.24618.arnd@arndb.de>
Message-ID: <50FED76B.10801@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/22/2013 11:47 AM, Arnd Bergmann wrote:
> On Tuesday 22 January 2013, Greg Kroah-Hartman wrote:
>>> Ie. I'd prefer to re-enable omapdss on multi-plat rather than
>>> disabling omapdrm.  With changes in drm core, it is a bit of a pain
>>> to compile test all the arm drivers by doing N different builds, so
>>> we've been trying to get to the point of all arm drm drivers
>>> supporting multi-plat
>> Ok, I'll let you and Arnd fight it out and drop this patch from my
>> to-apply queue for now...
> If Rob thinks there is no danger in allowing omap2_dss to be built
> on all platforms, and Tomi has no objections, I'm fine with that, too.
> In general, that is the right solution, I was just trying to be
> conservative for the 3.8 cycle.

I think it should be safe.. or at least it built fine for multi-plat in 
the recent past and shouldn't really do anything if there is no omapdss 
platform device.

Do you want me to make a patch or are you already doing this?

BR,
-R

> 	Arnd
