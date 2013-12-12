From: olof@lixom.net (Olof Johansson)
Date: Wed, 11 Dec 2013 17:12:16 -0800
Subject: [PATCH] MAINTAINERS: merge IMX6 entry into IMX
In-Reply-To: <20131211073445.GZ24559@pengutronix.de>
References: <20131210121626.39b3e543@ipc1.ka-ro>
 <1386685161-12758-1-git-send-email-shawn.guo@linaro.org>
 <20131211073445.GZ24559@pengutronix.de>
Message-ID: <20131212011216.GC21856@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 08:34:47AM +0100, Sascha Hauer wrote:
> On Tue, Dec 10, 2013 at 10:19:21PM +0800, Shawn Guo wrote:
> > I have been co-maintaining IMX sub-architecture for a couple of years,
> > and collecting IMX sub-architecture patches rather than IMX6 only ones
> > for a few release cycles.  It makes sense to officially add myself as
> > the co-maintainer for IMX sub-architecture now.  Consequently, IMX6
> > entry can just be merged into IMX.
> > 
> > While at it, add a 'F:' entry for IMX DTS files.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > ---
> >  MAINTAINERS |   11 +++--------
> >  1 file changed, 3 insertions(+), 8 deletions(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 13c15c8..c0cad90 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -894,18 +894,13 @@ F:	arch/arm/mach-footbridge/
> >  
> >  ARM/FREESCALE IMX / MXC ARM ARCHITECTURE
> >  M:	Sascha Hauer <kernel@pengutronix.de>
> > -L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> > -S:	Maintained
> > -T:	git git://git.pengutronix.de/git/imx/linux-2.6.git
> > -F:	arch/arm/mach-imx/
> > -F:	arch/arm/configs/imx*_defconfig
> > -
> > -ARM/FREESCALE IMX6
> >  M:	Shawn Guo <shawn.guo@linaro.org>
> 
> Put yourself ontop since you're doing way more for i.MX than I do.
> Otherwise:
> 
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Applied to fixes for 3.13 (switching the two M: lines as you proposed).


-Olof
