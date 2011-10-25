From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 25 Oct 2011 09:21:08 +0800
Subject: [PATCH v6 0/2] Add device tree support for i.mx51/53 boards
In-Reply-To: <20111018113208.GA30703@S2100-06.ap.freescale.net>
References: <1318812137-13991-1-git-send-email-shawn.guo@linaro.org>
	<20111018101846.GL18141@pengutronix.de>
	<20111018113208.GA30703@S2100-06.ap.freescale.net>
Message-ID: <20111025012107.GB2119@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Tue, Oct 18, 2011 at 07:32:10PM +0800, Shawn Guo wrote:
> On Tue, Oct 18, 2011 at 12:18:46PM +0200, Sascha Hauer wrote:
> > Shawn,
> > 
> > On Mon, Oct 17, 2011 at 08:42:15AM +0800, Shawn Guo wrote:
> > > Changes since v5:
> > >  * Retrieve fixed clock frequency from device tree
> > > 
> > > Changes since v4:
> > >  * Rebase onto imx-features branch
> > >  * Have devices in soc dtsi as "disabled" and explicitly enable the
> > >    ones in board dts as "okay"
> > >  * Utilize of_irq_init() infrastructure added by Rob Herring recently
> > > 
> > > Shawn Guo (2):
> > >       arm/mx5: add device tree support for imx53 boards
> > >       arm/mx5: add device tree support for imx51 babbage
> > 
> > You sent this patches to Arnd but without saying what he should do with
> > them. Shall I queue them up or does Arnd handle them? Same with the
> > include cleanup series.
> > 
> I sent them for review and planned to send a pull-request later.  But
> if you want to get them forwarded to Arnd, sure, please do.
> 
We need to get the patches showing up on linux-next before they are
going to Linus.  Have you got them ready for Arnd's for-next branch?
Please let me know if you expect I send pull-request to you to ease
your job.

-- 
Regards,
Shawn
