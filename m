From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 11 Mar 2015 10:06:01 +0100
Subject: [PATCH v9 0/5] i.MX6 PU power domain support
In-Reply-To: <20150311011236.GV20455@dragon>
References: <1424713215-3357-1-git-send-email-p.zabel@pengutronix.de>
 <20150311011236.GV20455@dragon>
Message-ID: <1426064761.3101.37.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Am Mittwoch, den 11.03.2015, 09:12 +0800 schrieb Shawn Guo:
> On Mon, Feb 23, 2015 at 06:40:10PM +0100, Philipp Zabel wrote:
> > Philipp Zabel (6):
> >   Documentation: Add device tree bindings for Freescale i.MX GPC
> >   ARM: imx6: gpc: Add PU power domain for GPU/VPU
> >   ARM: dts: imx6qdl: Add power-domain information to gpc node
> >   ARM: dts: imx6sl: Add power-domain information to gpc node
> >   ARM: dts: imx6qdl: Allow disabling the PU regulator, add a enable ramp
> >     delay
> 
> Applied above 5.
> 
> >   ARM: imx6: gpc: Allow PU regulator bypass
> 
> I only received 5 patches in the series.

Thank you, this shouldn't have appeared in the list at all.

Allowing regulator bypass isn't part of the series because I still
didn't manage to get rid of race conditions when enabling bypass on the
regulator used in two places (gpc and imx6q-cpufreq).

regards
Philipp
