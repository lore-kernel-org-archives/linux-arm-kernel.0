From: minghuan.lian@nxp.com (M.h. Lian)
Date: Wed, 30 Aug 2017 01:37:09 +0000
Subject: [PATCHv2 0/2] PCI: add ls2088a and ls1088a support
In-Reply-To: <20170829221954.GT8154@bhelgaas-glaptop.roam.corp.google.com>
References: <1501828894-25598-1-git-send-email-Zhiqiang.Hou@nxp.com>
 <20170829221954.GT8154@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <VI1PR04MB1615F2A640C2FB89F5B56380E89C0@VI1PR04MB1615.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

Thanks a lot.

 Acked-by: Minghuan Lian <minghuan.Lian@nxp.com>


Thanks,
Minghuan

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas at kernel.org]
> Sent: Wednesday, August 30, 2017 6:20 AM
> To: Z.q. Hou <zhiqiang.hou@nxp.com>
> Cc: linux-pci at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> bhelgaas at google.com; robh+dt at kernel.org; M.h. Lian
> <minghuan.lian@nxp.com>; shawnguo at kernel.org; Minghuan Lian
> <minghuan.Lian@freescale.com>; Mingkai Hu <mingkai.hu@freescale.com>;
> Roy Zang <tie-fei.zang@freescale.com>
> Subject: Re: [PATCHv2 0/2] PCI: add ls2088a and ls1088a support
> 
> [+cc Minghuan, Mingkai, Roy]
> 
> On Fri, Aug 04, 2017 at 02:41:32PM +0800, Zhiqiang Hou wrote:
> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> >
> > Hou Zhiqiang (2):
> >   PCI: layerscape: Add support for ls2088a
> >   PCI: layerscape: Add support for ls1088a
> >
> >  Documentation/devicetree/bindings/pci/layerscape-pci.txt |  2 ++
> >  drivers/pci/dwc/pci-layerscape.c                         | 10 ++++++++++
> >  2 files changed, 12 insertions(+)
> 
> These still apply cleanly, but I haven't seen an ack from the driver maintainers.
> 
> Bjorn
