From: zhiqiang.hou@nxp.com (Zhiqiang Hou)
Date: Thu, 24 Dec 2015 09:16:00 +0000
Subject: [PATCH] ARM64: dts: add LS1043a-QDS board support
In-Reply-To: <1450935615.18314.125.camel@freescale.com>
References: <1450935037-42930-1-git-send-email-Zhiqiang.Hou@freescale.com>
 <1450935615.18314.125.camel@freescale.com>
Message-ID: <HE1PR04MB0906CD54FAA8EED00DE1F4B384E70@HE1PR04MB0906.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Scott Wood [mailto:scottwood at freescale.com]
> Sent: 2015?12?24? 13:40
> To: Zhiqiang Hou <Zhiqiang.Hou@freescale.com>; devicetree at vger.kernel.org;
> robh+dt at kernel.org; mark.rutland at arm.com; pawel.moll at arm.com;
> ijc+devicetree at hellion.org.uk; galak at codeaurora.org; linux-arm-
> kernel at lists.infradead.org; catalin.marinas at arm.com; will.deacon at arm.com
> Cc: Mingkai.Hu at freescale.com; Shaohui.Xie at freescale.com
> Subject: Re: [PATCH] ARM64: dts: add LS1043a-QDS board support
> 
> On Thu, 2015-12-24 at 13:30 +0800, Zhiqiang Hou wrote:
> > +/dts-v1/;
> > +/include/ "fsl-ls1043a.dtsi"
> > +
> > +/ {
> > +	model = "LS1043A QDS Board";
> > +
> 
> compatible?

will add root node compatible in v2.

Thanks,
Zhiqiang
