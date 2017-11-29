From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 29 Nov 2017 10:55:46 +0100
Subject: [PATCH] MAINTAINERS: change maintainer for Rockchip drm drivers
In-Reply-To: <20171129095418.ixgwzo3m6bnqzad6@phenom.ffwll.local>
References: <1510568131-28838-1-git-send-email-mark.yao@rock-chips.com>
 <CAD=FV=W_c-ftX_jkZ7_RAdMZOtqcykiBOEMyB6dLWjuzkKwbDw@mail.gmail.com>
 <20171129095418.ixgwzo3m6bnqzad6@phenom.ffwll.local>
Message-ID: <19897082.KH862Wxx3L@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 29. November 2017, 10:54:18 CET schrieb Daniel Vetter:
> On Tue, Nov 28, 2017 at 03:42:36PM -0800, Doug Anderson wrote:
> > Hi,
> > 
> > On Sun, Nov 26, 2017 at 6:22 PM, Sandy Huang <hjc@rock-chips.com> wrote:
> > > Hi Daniel,
> > > 
> > >     I register the account and get the drm-misc commit rights now,
> > >     thanks.
> > > 
> > > ? 2017/11/24 22:51, Daniel Vetter ??:
> > >> On Fri, Nov 24, 2017 at 09:28:59AM +0100, Heiko Stuebner wrote:
> > >>> Hi Daniel,
> > >>> 
> > >>> [somehow my email address seems to have gotten lost, so
> > >>> only saw this by chance on the list itself now.
> > >>> I've also re-added Sandy to the recipients]
> > >>> 
> > >>> Am Montag, 20. November 2017, 08:48:48 CET schrieb Daniel Vetter:
> > >>>> On Mon, Nov 13, 2017 at 06:15:31PM +0800, Mark Yao wrote:
> > >>>>> For personal reasons, Mark Yao will leave rockchip,
> > >>>>> can not continue maintain drm/rockchip, Sandy Huang
> > >>>>> will take over the drm/rockchip.
> > >>>>> 
> > >>>>> Cc: Sandy Huang <hjc@rock-chips.com>
> > >>>>> Cc: Heiko Stuebner <heiko@sntech.de>
> > >>>>> 
> > >>>>> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> > >>>> 
> > >>>> Since rockchip is in drm-misc that means we need a new maintainer who
> > >>>> also
> > >>>> has drm-misc commit rights. Sandy doesn't yet, so if Sandy is going
> > >>>> to
> > >>>> be
> > >>>> the new maintainer we need to fix that.
> > >>>> 
> > >>>> Also, Heiko, are you interested in becoming co-maintainer? With
> > >>>> commit
> > >>>> rights and all.
> > >>> 
> > >>> I always feel somewhat inadequate judging the fast-paced drm stuff, as
> > >>> in
> > >>> the past once I got my head wrapped around something, drm always
> > >>> somehow moved another mile already ;-) .
> > >>> 
> > >>> But somewhere I read that drm-pace for big changes is supposed to slow
> > >>> a
> > >>> bit now that atomic modesetting is done in a lot of places, so we
> > >>> could
> > >>> give
> > >>> co-maintainership for the Rockchip-drm a try - with Sandy wearing the
> > >>> actual hat for big changes though ;-) .
> > >> 
> > >> Yeah I think on the modeset side it calmed down a lot. We're still
> > >> fine-tuning the helper libraries as we're figuring out better ways to
> > >> write drivers. But right now I think a lot of the action is all in
> > >> details
> > >> not relevant for many drivers.
> > >> 
> > >> If Sandy's ok with that too pls request an fd.o account for drm-misc
> > >> and
> > >> set up the tooling per our quickstart guide:
> > >> 
> > >> https://01.org/linuxgraphics/gfx-docs/maintainer-tools/dim.html#quickst
> > >> art
> > >> 
> > >> Thanks, Daniel
> > 
> > I just got a bounced mail from Mark Yao's old email address and
> > noticed that linux-next still shows him as the maintainer.  It'd be
> > great if we could land the change to update the MAINTAINERS file.  :-P
> 
> Patch just needs an ack from Heiko or Sean and it's good for Sandy to push
> to drm-misc.

Ok then, for the maintainer patch
Acked-by: Heiko Stuebner <heiko@sntech.de>
