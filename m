From: bhupesh.sharma@freescale.com (bhupesh.sharma at freescale.com)
Date: Wed, 1 Apr 2015 11:52:13 +0000
Subject: [PATCH 2/8] doc/bindings: Update PCIe devicetree binding
 documentation for LS2085A
In-Reply-To: <20150401114832.GD11403@leverpostej>
References: <1427888463-29549-1-git-send-email-bhupesh.sharma@freescale.com>
 <1427888463-29549-3-git-send-email-bhupesh.sharma@freescale.com>
 <20150401114832.GD11403@leverpostej>
Message-ID: <BY1PR0301MB1303976BAC27984A1D037C3A82F30@BY1PR0301MB1303.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

> From: Mark Rutland [mailto:mark.rutland at arm.com]
> 
> Hi,
> 
> On Wed, Apr 01, 2015 at 12:40:56PM +0100, Bhupesh Sharma wrote:
> > Add the documentation for compatible string "fsl,ls2085a-pcie"
> > for LS2085A platform.
> >
> > Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> 
> [...]
> 
> > Change-Id: I0d51607e86544be8906c996c08a2b2b558243bd4
> > Reviewed-on: http://git.am.freescale.net:8181/28740
> > Tested-by: Review Code-CDREVIEW <CDREVIEW@freescale.com>
> 
> These three are meaningless here. Please drop them.

Sorry. I just sent out a RESEND version. I pushed the send button too quickly :)

> 
> > Reviewed-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
> > Tested-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
> > ---
> >  .../devicetree/bindings/pci/layerscape-pci.txt     |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > index 6286f04..0654809 100644
> > --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > +++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > @@ -4,7 +4,8 @@ This PCIe host controller is based on the Synopsis
> > Designware PCIe IP  and thus inherits all the common properties defined
> in designware-pcie.txt.
> >
> >  Required properties:
> > -- compatible: should contain the platform identifier such as
> "fsl,ls1021a-pcie"
> > +- compatible: should contain the platform identifier such as
> > +"fsl,ls1021a-pcie",
> > +  "fsl,ls2085a-pcie".
> 
> Please format this as a list, e.g.
> 
> - compatible: schould contain one of:
>   * "fsl,ls1021a-pcie"
>   * "fsl,ls2085a-pcie"
> 
> Is the ls2085a PCIe controller significantly different from that of
> ls1021a? Is "fsl,ls1021a-pcie" valid as a fallback entry?
> 

Minghuan, can you please share your views on Mark's comments above. 

Regards,
Bhupesh
 
> >  - reg: base addresses and lengths of the PCIe controller
> >  - interrupts: A list of interrupt outputs of the controller. Must
> contain an
> >    entry for each entry in the interrupt-names property.
> > --
> > 1.7.9.5
> >
> >
