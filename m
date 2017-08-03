From: roy.zang@nxp.com (Roy Zang)
Date: Thu, 3 Aug 2017 18:22:48 +0000
Subject: [PATCH] PCI: layerscape: Add support for ls2088a and ls1088a
References: <1499333984-17668-1-git-send-email-Zhiqiang.Hou@nxp.com>
 <20170802212942.GA7667@bhelgaas-glaptop.roam.corp.google.com>
 <AM5PR0402MB2771BBF476E6A3DEFADE43F484B10@AM5PR0402MB2771.eurprd04.prod.outlook.com>
Message-ID: <DB6PR04MB2949CCDAADC03863B80852108BB10@DB6PR04MB2949.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/02/2017 10:36 PM, Z.q. Hou wrote:
> add "fsl,ls1088a-pcie" to ls_pcie_of_match[], then ls1088a pcie DT nodes use the compatible string "fsl,ls1088a-pcie"?

I'd suggest going this way.

Roy
