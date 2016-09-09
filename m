From: shaohui.xie@nxp.com (S.H. Xie)
Date: Fri, 9 Sep 2016 06:44:54 +0000
Subject: [PATCH 5/7] [v2] arm64: dts: add LS1046A-RDB board support
In-Reply-To: <20160908131218.GB16911@tiger>
References: <1473069695-33092-1-git-send-email-shh.xie@gmail.com>
 <1473069695-33092-6-git-send-email-shh.xie@gmail.com>
 <20160908131218.GB16911@tiger>
Message-ID: <DB5PR0401MB2183774C68CD9A7C93DDFE37E8FA0@DB5PR0401MB2183.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: Thursday, September 08, 2016 9:12 PM
> To: shh.xie at gmail.com
> Cc: devicetree at vger.kernel.org; robh+dt at kernel.org; mark.rutland at arm.com;
> linux-arm-kernel at lists.infradead.org; catalin.marinas at arm.com;
> will.deacon at arm.com; linux-kernel at vger.kernel.org; arnd at arndb.de; Vincent Hu
> <mingkai.hu@nxp.com>; S.H. Xie <shaohui.xie@nxp.com>
> Subject: Re: [PATCH 5/7] [v2] arm64: dts: add LS1046A-RDB board support
> 
> On Mon, Sep 05, 2016 at 06:01:33PM +0800, shh.xie at gmail.com wrote:
> > +&ifc {
> > +	status = "okay";
> 
> For sake of consistency, please have 'status' at the end of property list.
[S.H] Will fix it in next version.

Thanks,
Shaohui
