From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 11 Feb 2014 10:00:53 +0100
Subject: [RFC PATCH 2/3] staging: imx-drm-core: Use graph to find
 connection between crtc and encoder
In-Reply-To: <20140211083831.GV26722@mwanda>
References: <1389019922-31992-1-git-send-email-p.zabel@pengutronix.de>
 <1389019922-31992-3-git-send-email-p.zabel@pengutronix.de>
 <20140210162631.GC26684@n2100.arm.linux.org.uk>
 <20140211083831.GV26722@mwanda>
Message-ID: <1392109253.6943.0.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dan,

Am Dienstag, den 11.02.2014, 11:38 +0300 schrieb Dan Carpenter:
> > Why is this loop soo complicated?  Why do you need to mess around with
> > this "last_ep" stuff - you don't actually end up using it.
> > 
> > The loop reduces down to this without comments:
> > 
> >  	for (i = 0; !ret; i++) {
>                     ^^^^
> Philipp, "ret" isn't set anymore in the new loop.

thanks, I'll drop ret in the next version.

regards
Philipp
