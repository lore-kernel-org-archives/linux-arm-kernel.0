From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 20 Dec 2014 00:02:53 +0100
Subject: [PATCHv4] INPUT: Route keyboard LEDs through the generic LEDs
 layer.
In-Reply-To: <20141219225933.GD3049@type.youpi.perso.aquilenet.fr>
References: <20141210010214.GZ3074@type.youpi.perso.aquilenet.fr>
 <20141219144641.3a549feb1ee5f2b9400f62cb@linux-foundation.org>
 <20141219225933.GD3049@type.youpi.perso.aquilenet.fr>
Message-ID: <20141219230253.GA31928@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2014-12-19 23:59:33, Samuel Thibault wrote:
> Andrew Morton, le Fri 19 Dec 2014 14:46:41 -0800, a ?crit :
> > > Changed in this version:
> > > - Use kcalloc instead of kzalloc
> > > - to avoid any mutex order violation, defer LED update into a work callback.
> > 
> > Confused.  This patch is identical to the one that's presently in -mm.
> 
> Well, yes: I'm submitting the latest version of this patch to Dmitry,
> i.e. including the fixes that happened in the -mm tree.

Andrew, do you think you could send the patch to Dmitry? He has been
ignoring it for way too long... and it should be slightly harder for
him to ignore patch from you...

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
