From: roy.zang@nxp.com (Roy Zang)
Date: Mon, 17 Oct 2016 21:58:19 +0000
Subject: [PATCH] PCI: layerscape: Fix kernel panic on accessing NULL
 pointer
References: <1476740647-11155-1-git-send-email-leoyang.li@nxp.com>
Message-ID: <HE1PR0402MB2748D72F81AE2193AD2197A98BD00@HE1PR0402MB2748.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/17/2016 04:50 PM, Li Yang wrote:
> Commit fefe6733e added reference to the pcie->drvdata before it is
> initialized which causes a kernel panic.  Fix the problem by
> initializing the pcie->drvdata earlier before it is used.
>
> Reported-by: Stuart Yoder <stuart.yoder@nxp.com>
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---

 Acked-by:  Roy Zang <roy.zang@nxp.com>

Roy
