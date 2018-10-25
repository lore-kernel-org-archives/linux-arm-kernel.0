From: zhiqiang.hou@nxp.com (Z.q. Hou)
Date: Thu, 25 Oct 2018 09:27:42 +0000
Subject: [PATCH 1/4] doc/layerscape-pci: update the PCIe compatible strings
In-Reply-To: <20181017135148.GA29469@bogus>
References: <20181008031428.25293-1-Zhiqiang.Hou@nxp.com>
 <20181008031428.25293-2-Zhiqiang.Hou@nxp.com> <20181017135148.GA29469@bogus>
Message-ID: <DB5PR04MB12216556360604A225BAFC1F84F70@DB5PR04MB1221.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Thanks a lot for your comments!
 
> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: 2018?10?17? 21:52
> To: Z.q. Hou <zhiqiang.hou@nxp.com>
> Cc: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> linux-pci at vger.kernel.org; devicetree at vger.kernel.org; Leo Li
> <leoyang.li@nxp.com>; shawnguo at kernel.org; mark.rutland at arm.com;
> bhelgaas at google.com; Mingkai Hu <mingkai.hu@nxp.com>; M.h. Lian
> <minghuan.lian@nxp.com>
> Subject: Re: [PATCH 1/4] doc/layerscape-pci: update the PCIe compatible
> strings
> 
> On Mon, Oct 08, 2018 at 11:14:25AM +0800, Zhiqiang Hou wrote:
> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> >
> > The pcie compatible string for LS1043A was lost, so add it.
> 
> PCIe
> 
> The subject could be improved to say exactly what compatible string you are
> adding. And the subject should start with "dt-bindings: pci: ..."
>

Yes, will correct them in v2.
 
> >
> > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/pci/layerscape-pci.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > index 66df1e81e0b8..5eb1c202932f 100644
> > --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > +++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > @@ -18,6 +18,7 @@ Required properties:
> >          "fsl,ls2088a-pcie"
> >          "fsl,ls1088a-pcie"
> >          "fsl,ls1046a-pcie"
> > +        "fsl,ls1043a-pcie"
> >          "fsl,ls1012a-pcie"
> >  - reg: base addresses and lengths of the PCIe controller register blocks.
> >  - interrupts: A list of interrupt outputs of the controller. Must
> > contain an
> > --
> > 2.17.1
> >
