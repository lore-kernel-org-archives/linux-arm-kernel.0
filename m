From: laurentiu.tudor@nxp.com (Laurentiu Tudor)
Date: Mon, 11 Sep 2017 13:08:00 +0000
Subject: [PATCH v2] staging: fsl-mc: move bus driver out of staging
In-Reply-To: <20170911130303.GA2533@kroah.com>
References: <20170828105405.19552-1-laurentiu.tudor@nxp.com>
 <20170831160430.GB11200@kroah.com>
 <VI1PR0401MB185602CC352A4026BCD875CAEC680@VI1PR0401MB1856.eurprd04.prod.outlook.com>
 <20170911130303.GA2533@kroah.com>
Message-ID: <VI1PR0401MB185683F6C359916200A2919EEC680@VI1PR0401MB1856.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Greg KH [mailto:gregkh at linuxfoundation.org]
> Sent: Monday, September 11, 2017 4:03 PM
> 
> On Mon, Sep 11, 2017 at 11:55:22AM +0000, Laurentiu Tudor wrote:
> > Hi,
> >
> > > -----Original Message-----
> > > From: Greg KH [mailto:gregkh at linuxfoundation.org]
> > > Sent: Thursday, August 31, 2017 7:05 PM
> > >
> > > On Mon, Aug 28, 2017 at 01:54:05PM +0300, laurentiu.tudor at nxp.com
> wrote:
> > > > From: Stuart Yoder <stuart.yoder@nxp.com>
> > > >
> > > > Move the source files out of staging into their final locations:
> > > >   -include files in drivers/staging/fsl-mc/include go to include/linux/fsl
> > > >   -irq-gic-v3-its-fsl-mc-msi.c goes to drivers/irqchip
> > > >   -source in drivers/staging/fsl-mc/bus goes to drivers/bus/fsl-mc
> > > >   -README.txt, providing and overview of DPAA goes to
> > > >    Documentation/dpaa2/overview.txt
> > > >
> > > > Update or delete other remaining staging files-- Makefile, Kconfig, TODO.
> > > > Update dpaa2_eth and dpio staging drivers.
> > > >
> > > > Signed-off-by: Stuart Yoder <stuyoder@gmail.com>
> > > > Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > > > [Laurentiu: rebased, add dpaa2_eth and dpio #include updates]
> > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > Cc: Jason Cooper <jason@lakedaemon.net>
> > > > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > >
> > > This is going to have to wait until I get a chunk of time to do the review.
> > > Probably after 4.13-final is out.
> >
> > Any updates on this? Any chances to make it in 4.14? Thanks!
> 
> No, it's too late for 4.14, it would have had to be in linux-next before 4.13-final
> came out.  I'm at a conference all this week, 

Plumbers? :-)

> if I'm stuck in a boring talk, I'll try to do the review :)

Great. Thanks a lot for taking the time!

---
Best Regards, Laurentiu
