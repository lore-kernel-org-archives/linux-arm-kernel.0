From: Mingkai.Hu@freescale.com (Hu Vincent)
Date: Tue, 15 Dec 2015 02:05:06 +0000
Subject: [PATCH v2] dts/ls2080a: Update PCIe compatible
In-Reply-To: <1450144975.15946.410.camel@freescale.com>
References: <1449224417-20753-1-git-send-email-Mingkai.Hu@freescale.com>
 <20151204162243.GA12415@rob-hp-laptop>
 <BY2PR03MB3160E6BF80C63C5DF0AB91F84EE0@BY2PR03MB316.namprd03.prod.outlook.com>
 <1450144975.15946.410.camel@freescale.com>
Message-ID: <BY2PR03MB3163EAB63391DB671C7E54784EE0@BY2PR03MB316.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Tuesday, December 15, 2015 10:03 AM
> To: Hu Mingkai-B21284; Rob Herring
> Cc: arm at kernel.org; devicetree at vger.kernel.org; Li Yang-Leo-R58472;
> linux-arm-kernel at lists.infradead.org; Lian Minghuan-B31939
> Subject: Re: [PATCH v2] dts/ls2080a: Update PCIe compatible
> 
> On Mon, 2015-12-14 at 20:01 -0600, Hu Mingkai-B21284 wrote:
> >
> > > -----Original Message-----
> > > From: Hu Mingkai-B21284
> > > Sent: Monday, December 07, 2015 4:44 PM
> > > To: 'Rob Herring'
> > > Cc: arm at kernel.org; devicetree at vger.kernel.org; Li Yang-Leo-R58472;
> > > linux-arm-kernel at lists.infradead.org; Lian Minghuan-B31939
> > > Subject: RE: [PATCH v2] dts/ls2080a: Update PCIe compatible
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Rob Herring [mailto:robh at kernel.org]
> > > > Sent: Saturday, December 05, 2015 12:23 AM
> > > > To: Hu Mingkai-B21284
> > > > Cc: arm at kernel.org; devicetree at vger.kernel.org; Li
> > > > Yang-Leo-R58472; linux-arm-kernel at lists.infradead.org; Lian
> > > > Minghuan-B31939
> > > > Subject: Re: [PATCH v2] dts/ls2080a: Update PCIe compatible
> > > >
> > > > On Fri, Dec 04, 2015 at 06:20:17PM +0800, Mingkai Hu wrote:
> > > > > From: Minghuan Lian <Minghuan.Lian@freescale.com>
> > > > >
> > > > > The patch adds LS2085a to PCIe compatible to fix the
> > > > > compatibility issue when using firmware with LS2085a compatible
> property.
> > > > >
> > > > > Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> > > > > Signed-off-by: Mingkai Hu <Mingkai.Hu@freescale.com>
> > > > > ---
> > > > > v2 change:
> > > > >  - Rebased to latest kernel base
> > > >
> > > > How about implementing my comments on v1, too?
> > > >
> > >
> > > Hi Rob,
> > >
> > > Do you mean to change the combinations in layerscape-pci.txt as
> follows?
> > >
> > > > --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > > > +++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > > > @@ -15,6 +15,7 @@ Required properties:
> > > >  - compatible: should contain the platform identifier such as:
> > > >          "fsl,ls1021a-pcie", "snps,dw-pcie"
> > > > -        "fsl,ls2080a-pcie", "snps,dw-pcie"
> > > > +        "fsl,ls2080a-pcie", "fsl,ls2085a-pcie", "snps,dw-pcie"
> > >
> > >
> > > And the ls2085a was released first, but the dts file is for ls2080a
> > > (fsl- ls2080a.dtsi), So I prefer to put the ls2080a as the first
> > > compatible string. How about your suggestion?
> > >
> >
> > Hi Rob,
> >
> > I will keep the "fsl,ls2085a-pcie" as the first compatible string as
> > discussed.
> 
> Do you mean "fsl,ls2080a-pcie"?
> 

Oops. Yes, it's "fsl,ls2080a-pcie ".

Thanks,
Mingkai
