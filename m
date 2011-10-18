From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Oct 2011 11:25:31 +0100
Subject: [PATCH v6 0/2] Add device tree support for i.mx51/53 boards
In-Reply-To: <20111018101846.GL18141@pengutronix.de>
References: <1318812137-13991-1-git-send-email-shawn.guo@linaro.org>
	<20111018101846.GL18141@pengutronix.de>
Message-ID: <20111018102531.GN21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2011 at 12:18:46PM +0200, Sascha Hauer wrote:
> Shawn,
> 
> On Mon, Oct 17, 2011 at 08:42:15AM +0800, Shawn Guo wrote:
> > Changes since v5:
> >  * Retrieve fixed clock frequency from device tree
> > 
> > Changes since v4:
> >  * Rebase onto imx-features branch
> >  * Have devices in soc dtsi as "disabled" and explicitly enable the
> >    ones in board dts as "okay"
> >  * Utilize of_irq_init() infrastructure added by Rob Herring recently
> > 
> > Shawn Guo (2):
> >       arm/mx5: add device tree support for imx53 boards
> >       arm/mx5: add device tree support for imx51 babbage
> 
> You sent this patches to Arnd but without saying what he should do with
> them. Shall I queue them up or does Arnd handle them? Same with the
> include cleanup series.

I think you should - the arm-soc tree is there to act as an integration
tree for the various SoC maintainers.  Patches for SoCs where there's
an active maintainer should still be handled by the SoC maintainer (and
either applied to their git tree or forwarded upstream) unless there is
agreement to do otherwise.
