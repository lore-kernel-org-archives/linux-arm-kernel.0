From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 26 Nov 2012 08:58:48 -0500
Subject: [GIT PULL 3/5] ARM: orion: boards for v3.8
In-Reply-To: <20121126091913.GC13866@quad.lixom.net>
References: <pull-1353733874-990435>
 <50b056f7.452ce00a.4217.69b0SMTPIN_ADDED_MISSING@mx.google.com>
 <20121126091913.GC13866@quad.lixom.net>
Message-ID: <20121126135848.GA15800@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2012 at 01:19:13AM -0800, Olof Johansson wrote:
> On Sat, Nov 24, 2012 at 05:11:09AM +0000, Jason Cooper wrote:
> > The following changes since commit f4a75d2eb7b1e2206094b901be09adb31ba63681:
> > 
> >   Linux 3.7-rc6 (2012-11-16 17:42:40 -0800)
> > 
> > are available in the git repository at:
> > 
> >   git://git.infradead.org/users/jcooper/linux.git tags/orion_boards_for_3.8
> 
> Pulled, thanks. I commented on one of the patches though (Network Space v2).
> 
> Obviously the mpp pieces of each board patch will go away now that the pinctrl
> driver is in place, so hopefully most of the rest can be whittled down too over
> the next couple of releases. :)

I'm targetting v3.9 to get rid of most of the board files, the Kconfig
of individual DT boards, and platform init of mv643xx_eth.  At that
point, we'll be in shape to convert the legacy *-setup.c files, and move
all DT support to mvebu.

thx,

Jason.
