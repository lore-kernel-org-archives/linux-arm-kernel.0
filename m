From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 25 May 2017 14:23:49 +0800
Subject: [PATCH V2 4/5] dt-bindings: pinctrl: add imx7ulp pinctrl binding
 doc
In-Reply-To: <AM3PR04MB3068FA0B94C9B0D6269FC9C80FF0@AM3PR04MB306.eurprd04.prod.outlook.com>
References: <1495177545-23006-1-git-send-email-aisheng.dong@nxp.com>
 <1495177545-23006-5-git-send-email-aisheng.dong@nxp.com>
 <5e78ef100319f229a87e33804384e5b3@agner.ch>
 <DBXPR04MB320A55DE4386DE561A1D4DC80F90@DBXPR04MB320.eurprd04.prod.outlook.com>
 <20170525031620.GS26102@dragon>
 <AM3PR04MB3068FA0B94C9B0D6269FC9C80FF0@AM3PR04MB306.eurprd04.prod.outlook.com>
Message-ID: <20170525062347.GT26102@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 25, 2017 at 05:04:58AM +0000, A.S. Dong wrote:
> If we really want to change, 'IMX7ULP1' may be a little strange as 'IMX7ULP' is
> the official external name and all other places are using it.
> So IMX7ULP may be more suitable.

Yes, I actually meant IMX7ULP, which matches how we name the SoC
elsewhere in the kernel.

> 
> Then next generation may be:
> IMX7ULP0_PAD_PTC0_PTC0.
> Vs
> IMX7ULP_PAD_PTC0_PTC0
> 
> Just not much better than:
> ULP1_PAD_PTC0_PTC0.
> vs
> ULP0_PAD_PTC0_PTC0
> 
> That's why I did not do it initially.
> 
> However, if you do want the change, i'm okay to do it.

For the next generation, we will have a name for it in the kernel
anyway.  The pinctrl macro simply follows that name.

Shawn
