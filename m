From: robh@kernel.org (Rob Herring)
Date: Wed, 8 Jun 2016 14:40:43 -0500
Subject: [PATCH v4 3/7] binding: mdio-mux: Add DT binding doc for
 Broadcom MDIO bus multiplexer
In-Reply-To: <f6cd5df22ef8ea070d7b35e628b6d25a@mail.gmail.com>
References: <1465216900-11755-1-git-send-email-pramod.kumar@broadcom.com>
 <1465216900-11755-4-git-send-email-pramod.kumar@broadcom.com>
 <5755C290.2020704@gmail.com>
 <f6cd5df22ef8ea070d7b35e628b6d25a@mail.gmail.com>
Message-ID: <20160608194043.GA32093@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2016 at 05:27:29PM +0530, Pramod Kumar wrote:
> Hi Florian,
> 
> > -----Original Message-----
> > From: Florian Fainelli [mailto:f.fainelli at gmail.com]
> > Sent: 07 June 2016 00:06
> > To: Pramod Kumar; Rob Herring; Pawel Moll; Mark Rutland; Ian Campbell;
> > Kumar Gala; Catalin Marinas; Will Deacon; Kishon Vijay Abraham I; David S.
> > Miller
> > Cc: devicetree at vger.kernel.org; netdev at vger.kernel.org; linux-
> > kernel at vger.kernel.org; bcm-kernel-feedback-list at broadcom.com; linux-arm-
> > kernel at lists.infradead.org
> > Subject: Re: [PATCH v4 3/7] binding: mdio-mux: Add DT binding doc for
> > Broadcom MDIO bus multiplexer
> >
> > On 06/06/2016 05:41 AM, Pramod Kumar wrote:
> > > Add DT binding doc for Broadcom MDIO bus multiplexer driver.
> > >
> > > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > > Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
> >
> > Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> >
> >
> > > +for example:
> > > +		mdio_mux_iproc: mdio-mux at 6602023c {
> >
> > I think Rob wanted you to drop the underscores here in favor of dashes,
> > there
> > are more below, not critical imho.
> >
> 
> I'd changed node name in favor of dashes. I don't think Label could be
> written with hyphens,"-".  "-" in label provides DT parsing error.

Right. Labels don't matter as they aren't part of the binding.

Rob
