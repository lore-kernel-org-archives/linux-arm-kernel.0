From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 21 Feb 2014 20:09:39 -0500
Subject: [GIT PULL] ARM: mvebu: defconfig changes for v3.15
In-Reply-To: <20140222003641.GF13233@quad.lixom.net>
References: <20140218164639.GX7862@titan.lakedaemon.net>
 <20140222003641.GF13233@quad.lixom.net>
Message-ID: <20140222010939.GQ7862@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 21, 2014 at 04:36:41PM -0800, Olof Johansson wrote:
> On Tue, Feb 18, 2014 at 11:46:39AM -0500, Jason Cooper wrote:
...
> > Ezequiel Garcia (3):
> >       ARM: dove: Remove UBI support from defconfig
> >       ARM: mvebu: Enable watchdog support in defconfig
> >       ARM: dove: Enable watchdog support in the defconfig
> > 
> > Thomas Petazzoni (3):
> >       ARM: mvebu: rename mvebu_defconfig to mvebu_v7_defconfig
> >       ARM: mvebu: enable audio options in mvebu_defconfig

> >       ARM: mvebu: update defconfigs for Armada 375 and 38x

merf.  I'll make sure this is two patches in the future.

> > 
> >  arch/arm/configs/dove_defconfig                          | 3 ++-
> >  arch/arm/configs/multi_v7_defconfig                      | 4 ++++
> >  arch/arm/configs/{mvebu_defconfig => mvebu_v7_defconfig} | 9 +++++++++
> >  3 files changed, 15 insertions(+), 1 deletion(-)
> >  rename arch/arm/configs/{mvebu_defconfig => mvebu_v7_defconfig} (91%)
> 
> Jason,
> 
> multi_v7_defconfig updates get messy, and we ask that people send them as
> patches instead of in branches. Still, in this case it's a whole branch of just
> defconfig updates so I think we'll be OK. Be mindful of it in the future
> though, please.

Ok, I'll just ack patches to multi_v?_defconfig from here on out.
Thanks for the heads up.

> Branch has been merged into next/boards.

If you need me to respin, just let me know.  The patch I singled out
above might be problematic.

thx,

Jason.
