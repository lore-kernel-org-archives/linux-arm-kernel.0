From: shaohui.xie@nxp.com (S.H. Xie)
Date: Fri, 9 Sep 2016 06:46:37 +0000
Subject: [PATCH 3/7] [v2] arm64: dts: add QorIQ LS1046A SoC support
In-Reply-To: <20160908130549.GA16911@tiger>
References: <1473069695-33092-1-git-send-email-shh.xie@gmail.com>
 <1473069695-33092-4-git-send-email-shh.xie@gmail.com>
 <20160908130549.GA16911@tiger>
Message-ID: <DB5PR0401MB21837ABC4366AA0040A235A3E8FA0@DB5PR0401MB2183.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: Thursday, September 08, 2016 9:06 PM
> To: shh.xie at gmail.com
> Cc: devicetree at vger.kernel.org; robh+dt at kernel.org; mark.rutland at arm.com;
> linux-arm-kernel at lists.infradead.org; catalin.marinas at arm.com;
> will.deacon at arm.com; linux-kernel at vger.kernel.org; Mihai Emilian Bantea
> <mihai.bantea@nxp.com>; C.H. Zhao <chenhui.zhao@nxp.com>; arnd at arndb.de;
> S.H. Xie <shaohui.xie@nxp.com>; Z.Q. Hou <zhiqiang.hou@nxp.com>; M.H. Lian
> <minghuan.lian@nxp.com>; Vincent Hu <mingkai.hu@nxp.com>; Horia Geanta
> Neag <horia.geanta@nxp.com>; Q.Y. Gong <qianyu.gong@nxp.com>
> Subject: Re: [PATCH 3/7] [v2] arm64: dts: add QorIQ LS1046A SoC support
> 
> On Mon, Sep 05, 2016 at 06:01:31PM +0800, shh.xie at gmail.com wrote:
> > +	soc {
> > +		compatible = "simple-bus";
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +		ranges;
> > +
> > +		clockgen: clocking at 1ee1000 {
> > +			compatible = "fsl,ls1046a-clockgen";
> > +			reg = <0x0 0x1ee1000 0x0 0x1000>;
> > +			#clock-cells = <2>;
> > +			clocks = <&sysclk>;
> > +		};
> > +
> > +		scfg: scfg at 1570000 {
> 
> Instead of having device node in arbitrary place, can we sort all the nodes under
> 'simple-bus' in order of unit-address?
[S.H] Will sort the nodes in order of unit-address in next version.

Thanks,
Shaohui
