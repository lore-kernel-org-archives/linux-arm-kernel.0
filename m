From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 19 Dec 2011 18:22:28 +0100 (CET)
Subject: [GIT PULL] imx: gpio interrupt cleanup
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF176BE92A13@HQMAIL01.nvidia.com>
References: <20111208143204.GA8139@S2100-06.ap.freescale.net>
 <74CDBE0F657A3D45AFBB94109FB122FF176BE92A13@HQMAIL01.nvidia.com>
Message-ID: <alpine.LFD.2.02.1112191821190.3020@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Dec 2011, Stephen Warren wrote:

> Behalf Of Shawn Guo wrote at Thursday, December 08, 2011 7:32 AM:
> > Hi Arnd and  Olof,
> > 
> > Please consider to pull the series below.  I really should have
> > Thomas' ack on Jamie's patch 'irqdomain: export irq_domain_simple_ops
> > for !CONFIG_OF', and Grant's ack on patch 'gpio/mxc: adopt irq_domain
> > in gpio driver'.  So this pull request is also asking comments for the
> > path of these patches.
> > 
> > Thomas, Grant,
> > 
> > Please speak up if you do not want "your" patches to go through arm-soc
> > tree.  Thanks.
> 
> Thomas,
> 
> I'm waiting on the following patch, since I need it to complete a patch
> I'm working on:
> 
> > Jamie Iles (1):
> >       irqdomain: export irq_domain_simple_ops for !CONFIG_OF
> 
> Can you ack it for inclusion in the arm-soc tree, or apply it, so I know
> it's OK to rely on this patch in my work?

If there is nothing else depending on those patches than the arm soc
stuff, them they can go through it with my acked by. Otherwise let me
know, then I pick them up into a branch to pull for you.

Thanks,

	tglx
