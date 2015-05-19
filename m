From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 19 May 2015 16:33:10 +0200
Subject: [PATCH v2] arm, imx6, dts: add DT for aristainetos2 board
In-Reply-To: <555B3E3A.8000605@denx.de>
References: <1431334974-27531-1-git-send-email-hs@denx.de>
 <20150518113135.GD1071@dragon> <555AE192.8010700@denx.de>
 <1432025280.3182.6.camel@pengutronix.de> <555B3E3A.8000605@denx.de>
Message-ID: <1432045990.15181.36.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

Am Dienstag, den 19.05.2015, 15:44 +0200 schrieb Heiko Schocher:
> Hello Philipp,
> 
> Am 19.05.2015 10:48, schrieb Philipp Zabel:
> > Hi Heiko, Shawn,
> >
> > Am Dienstag, den 19.05.2015, 09:09 +0200 schrieb Heiko Schocher:
> > [...]
> >>> What is this?  I failed to find it in Documentation/devicetree/bindings/
> >>
> >> Ah, this is not documentated, see commit:
> >>
> >> commit 628f435be4359e6ae8ecfdda9b492053be76a057
> >> Author: Philipp Zabel <p.zabel@pengutronix.de>
> >> Date:   Tue Feb 25 11:55:04 2014 +0100
> >>
> >>       imx-drm: parallel-display: Add drm_panel support
> >>
> >> added Philipp to cc ...
> >
> > This was meant to be a temporary solution to connect a drm_panel to the
> > parallel-display when the of-graph bindings were not yet available.
> > I'd very much prefer to switch to the common of-graph bindings similarly
> > to the LDB driver instead. Could you check if this would work for you:
> 
> Yes, your patch works for me (with appropriate changes in the dts file)
> You can add my
> Tested-by: Heiko Schocher <hs@denx.de>
> for this patch, thanks!

Thank you, I've posted that parallel-display patch and will try to queue
it for v4.2 when it gets accepted.

regards
Philipp
