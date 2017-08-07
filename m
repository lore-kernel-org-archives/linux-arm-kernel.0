From: zhiqiang.hou@nxp.com (Z.q. Hou)
Date: Mon, 7 Aug 2017 02:05:06 +0000
Subject: [PATCHv2 0/3] dts: add ls2088a and 1088a pcie DT nodes
In-Reply-To: <20170805054627.GU31819@dragon>
References: <1501829046-3761-1-git-send-email-Zhiqiang.Hou@nxp.com>
 <20170805054627.GU31819@dragon>
Message-ID: <VI1PR0402MB278248A2FD55FD70FA9B262184B50@VI1PR0402MB2782.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Thanks a lot for your comments!

> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: 2017?8?5? 13:46
> To: Z.q. Hou <zhiqiang.hou@nxp.com>
> Cc: linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org;
> robh+dt at kernel.org; mark.rutland at arm.com; catalin.marinas at arm.com;
> will.deacon at arm.com; Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
> Subject: Re: [PATCHv2 0/3] dts: add ls2088a and 1088a pcie DT nodes
> 
> On Fri, Aug 04, 2017 at 02:44:03PM +0800, Zhiqiang Hou wrote:
> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> >
> > Add GICv3 ITS DT node for ls1088a, because the PCIe nodes must have a
> > msi-parent.
> >
> > Hou Zhiqiang (3):
> >   dts: ls2088a: add pcie support
> >   dts: ls1088a: add gicv3 ITS DT node
> >   dts: ls1088a: add PCIe controller DT nodes
> 
> Please have an additional 'arm64: ' prefix for these arm64 dts patches.

yes, will add next version.

Thanks,
Zhiqiang
