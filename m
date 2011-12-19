From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 19 Dec 2011 09:40:41 -0800
Subject: [GIT PULL] imx: gpio interrupt cleanup
In-Reply-To: <20111219172903.GK2351@totoro>
References: <20111208143204.GA8139@S2100-06.ap.freescale.net>
 <74CDBE0F657A3D45AFBB94109FB122FF176BE92A13@HQMAIL01.nvidia.com>
 <20111219172903.GK2351@totoro>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF176BE92A37@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jamie Iles wrote at Monday, December 19, 2011 10:29 AM:
> On Mon, Dec 19, 2011 at 09:20:34AM -0800, Stephen Warren wrote:
> > Behalf Of Shawn Guo wrote at Thursday, December 08, 2011 7:32 AM:
> > > Hi Arnd and  Olof,
> > >
> > > Please consider to pull the series below.  I really should have
> > > Thomas' ack on Jamie's patch 'irqdomain: export irq_domain_simple_ops
> > > for !CONFIG_OF', and Grant's ack on patch 'gpio/mxc: adopt irq_domain
> > > in gpio driver'.  So this pull request is also asking comments for the
> > > path of these patches.
> > >
> > > Thomas, Grant,
> > >
> > > Please speak up if you do not want "your" patches to go through arm-soc
> > > tree.  Thanks.
> >
> > Thomas,
> >
> > I'm waiting on the following patch, since I need it to complete a patch
> > I'm working on:
> >
> > > Jamie Iles (1):
> > >       irqdomain: export irq_domain_simple_ops for !CONFIG_OF
> >
> > Can you ack it for inclusion in the arm-soc tree, or apply it, so I know
> > it's OK to rely on this patch in my work?
> 
> Thomas has acked this and it's in Russell's tracker as 7235/1 as I have
> a VIC patch that uses it too.

Ah, I missed that.

Is it in a stable git tree anywhere, so that it can be used as a
dependency for my patch in the arm-soc tree? It certainly hasn't shown
up in today's next.

Thanks.

-- 
nvpublic
