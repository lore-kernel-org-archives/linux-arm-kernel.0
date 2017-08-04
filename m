From: zhiqiang.hou@nxp.com (Z.q. Hou)
Date: Fri, 4 Aug 2017 03:46:39 +0000
Subject: [PATCH] PCI: layerscape: Add support for ls2088a and ls1088a
In-Reply-To: <DB6PR04MB2949CCDAADC03863B80852108BB10@DB6PR04MB2949.eurprd04.prod.outlook.com>
References: <1499333984-17668-1-git-send-email-Zhiqiang.Hou@nxp.com>
 <20170802212942.GA7667@bhelgaas-glaptop.roam.corp.google.com>
 <AM5PR0402MB2771BBF476E6A3DEFADE43F484B10@AM5PR0402MB2771.eurprd04.prod.outlook.com>
 <DB6PR04MB2949CCDAADC03863B80852108BB10@DB6PR04MB2949.eurprd04.prod.outlook.com>
Message-ID: <AM5PR0402MB27716C990B0A0BF8DA807F3A84B60@AM5PR0402MB2771.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roy,

Thanks a lot for your comments!

> -----Original Message-----
> From: Roy Zang
> Sent: 2017?8?4? 2:23
> To: Z.q. Hou <zhiqiang.hou@nxp.com>; Bjorn Helgaas <helgaas@kernel.org>
> Cc: linux-pci at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> bhelgaas at google.com; robh+dt at kernel.org; Minghuan Lian
> <minghuan.Lian@freescale.com>; Mingkai Hu <mingkai.hu@freescale.com>;
> Roy Zang <tie-fei.zang@freescale.com>
> Subject: Re: [PATCH] PCI: layerscape: Add support for ls2088a and ls1088a
> 
> On 08/02/2017 10:36 PM, Z.q. Hou wrote:
> > add "fsl,ls1088a-pcie" to ls_pcie_of_match[], then ls1088a pcie DT nodes use
> the compatible string "fsl,ls1088a-pcie"?
> 
> I'd suggest going this way.

Yes, thanks for the suggestion.

Thanks,
Zhiqiang
