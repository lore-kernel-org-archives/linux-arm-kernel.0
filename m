From: bhupesh.sharma@freescale.com (Sharma Bhupesh)
Date: Sun, 6 Sep 2015 20:00:10 +0000
Subject: [PATCH v2 04/10] doc/bindings: Update PCIe devicetree binding
 documentation for LS2080A
In-Reply-To: <DM2PR0301MB0640B355ADF0CF1AD514B2A1E2550@DM2PR0301MB0640.namprd03.prod.outlook.com>
References: <1441349872-4560-1-git-send-email-bhupesh.sharma@freescale.com>
 <1441349872-4560-5-git-send-email-bhupesh.sharma@freescale.com>
 <CADRPPNRGpzWawsqLHCiv530HbtPf+9RaPzOtvy88ftwv2ffqLQ@mail.gmail.com>
 <BY1PR0301MB13037F8BC0A8E1E4258F58DE82570@BY1PR0301MB1303.namprd03.prod.outlook.com>
 <DM2PR0301MB0640B355ADF0CF1AD514B2A1E2550@DM2PR0301MB0640.namprd03.prod.outlook.com>
Message-ID: <BY1PR0301MB1303B2794EF0CE4FCB51CE0982550@BY1PR0301MB1303.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Lian Minghuan-B31939
> Sent: Sunday, September 06, 2015 7:56 AM
> Hi Bhupesh
> 
> I agree with Leo whose suggestion is a better.

Ok, thanks.

I will make this change in v3 patchset then.

Regards,
Bhupesh

> > From: Sharma Bhupesh-B45370
> > Sent: Saturday, September 05, 2015 4:20 AM
> > > From: Leo Li [mailto:pku.leo at gmail.com]
> > > Sent: Friday, September 04, 2015 11:27 PM On Fri, Sep 4, 2015 at
> > > 1:57 AM, Bhupesh Sharma <bhupesh.sharma@freescale.com> wrote:
> > > > Add the documentation for compatible string "fsl,ls2080a-pcie"
> > > > for Freescale's LS2080A platform.
> > > >
> > > > Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> > > > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
> > > > ---
> > > >  .../devicetree/bindings/pci/layerscape-pci.txt     |    3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > > > b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > > > index 6286f04..e72e68f 100644
> > > > --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > > > +++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > > > @@ -4,7 +4,8 @@ This PCIe host controller is based on the Synopsis
> > > > Designware PCIe IP  and thus inherits all the common properties
> > > > defined
> > > in designware-pcie.txt.
> > > >
> > > >  Required properties:
> > > > -- compatible: should contain the platform identifier such as
> > > "fsl,ls1021a-pcie"
> > > > +- compatible: should contain the platform identifier such as
> > > > +"fsl,ls1021a-pcie",
> > > > +  "fsl,ls2080a-pcie".
> > >
> > > Make it generic like "fsl,<chip>-pcie"
> >
> > Minghuan, if you don't have an objection, I would like to address
> > Leo's suggestion in v3 of this series as I think it is a valid one.
> >
> > Please share your views.
> >
> > Regards,
> > Bhupesh
