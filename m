From: shaohui.xie@nxp.com (S.H. Xie)
Date: Fri, 9 Sep 2016 06:48:14 +0000
Subject: [PATCH 3/7] [v2] arm64: dts: add QorIQ LS1046A SoC support
In-Reply-To: <20160908131326.GE26570@leverpostej>
References: <1473069695-33092-1-git-send-email-shh.xie@gmail.com>
 <1473069695-33092-4-git-send-email-shh.xie@gmail.com>
 <20160908131326.GE26570@leverpostej>
Message-ID: <DB5PR0401MB218327FA907E7224994C09BCE8FA0@DB5PR0401MB2183.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +	pmu {
> > +		compatible = "arm,armv8-pmuv3";
> > +		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
> > +			     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
> > +			     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
> > +			     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
> > +		interrupt-affinity = <&cpu0>,
> > +				     <&cpu1>,
> > +				     <&cpu2>,
> > +				     <&cpu3>;
> > +	};
> 
> The compatible string should be "arm,cortex-a72-pmu".
[S.H] Will fix it in next version.

Thanks,
Shaohui
