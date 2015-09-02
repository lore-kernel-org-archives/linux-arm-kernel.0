From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 2 Sep 2015 16:14:50 +0100
Subject: [PATCH 6/7] MAINTAINERS: Add FDMA driver files to STi section.
In-Reply-To: <20150826073351.GU19409@x1>
References: <1436371888-27863-1-git-send-email-peter.griffin@linaro.org>
 <1436371888-27863-7-git-send-email-peter.griffin@linaro.org>
 <20150826073351.GU19409@x1>
Message-ID: <20150902151450.GB15477@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Wed, 26 Aug 2015, Lee Jones wrote:

> On Wed, 08 Jul 2015, Peter Griffin wrote:
> 
> > This patch adds the FDMA driver files to the STi
> > section of the maintainers file.
> > 
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > ---
> >  MAINTAINERS | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 8133cef..8cb1ad9 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1503,6 +1503,8 @@ S:	Maintained
> >  F:	arch/arm/mach-sti/
> >  F:	arch/arm/boot/dts/sti*
> >  F:	drivers/clocksource/arm_global_timer.c
> > +F:	drivers/dma/st_fdma.*
> > +F:	drivers/dma/st_fdma_xbar.c
> 
> How about you replace both lines with:
> 
> F:	drivers/dma/st_fdma*

Ok, will fix in next version.

regards,

Peter.
