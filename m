From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Tue, 01 Mar 2011 20:56:39 +0000
Subject: [patch 1/2] mc13892: reboot on wdi event
In-Reply-To: <87k4gkyydi.fsf@lebrac.rtp-net.org>
References: <20110228132132.654689676@rtp-net.org>
	<20110228132643.964403175@rtp-net.org>
	<20110228143552.GC13869@opensource.wolfsonmicro.com>
	<87k4gkyydi.fsf@lebrac.rtp-net.org>
Message-ID: <1299012999.3345.80.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-02-28 at 16:25 +0100, Arnaud Patard wrote:
> Mark Brown <broonie@opensource.wolfsonmicro.com> writes:
> 
> > On Mon, Feb 28, 2011 at 02:21:33PM +0100, Arnaud Patard wrote:
> >> By default, on wdi (watchdog input) event the mc13892 is powering off.
> >> This patch is changing this to reboot on wdi event.
> >> 
> >> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> >
> > This strikes me as something that should be configurable by platforms.
> 
> afaik, mc13892 is used only on imx designs and the reset for imx is done
> only throught the watchdog. From this point of view,  I don't see any
> valid reason for powering off instead of rebooting on watchdog event
> 

If this change is for i.MX only then it should be optional as Freescale
probably will sell this PMIC to non i.MX users.

Thanks

Liam
