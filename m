From: B48286@freescale.com (Hou Zhiqiang)
Date: Thu, 15 Oct 2015 03:32:40 +0000
Subject: [PATCH V3 4/6] arm64/ls1043a: add DTS for Freescale LS1043A SoC
In-Reply-To: <20151014124353.GC2150@leverpostej>
References: <1444822498-16477-1-git-send-email-B48286@freescale.com>
 <1444822498-16477-5-git-send-email-B48286@freescale.com>
 <20151014124353.GC2150@leverpostej>
Message-ID: <CY1PR0301MB07803635FF7E642C48EDE3648B3E0@CY1PR0301MB0780.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland at arm.com]
> Sent: 2015?10?14? 20:44
> To: Hou Zhiqiang-B48286
> Cc: linux-arm-kernel at lists.infradead.org; catalin.marinas at arm.com;
> will.deacon at arm.com; linux-i2c at vger.kernel.org; linux-
> watchdog at vger.kernel.org; linux-doc at vger.kernel.org; linux-
> clk at vger.kernel.org; Hu Mingkai-B21284; Xie Shaohui-B21989; Wood Scott-
> B07421; Sharma Bhupesh-B45370; Li Yang-Leo-R58472; wsa at the-dreams.de;
> wim at iguana.be; corbet at lwn.net; mturquette at baylibre.com;
> sboyd at codeaurora.org; Song Wenbin-B53747
> Subject: Re: [PATCH V3 4/6] arm64/ls1043a: add DTS for Freescale LS1043A
> SoC
> 
> Hi,
> 
> > +	pmu {
> > +		compatible = "arm,armv8-pmuv3";
> > +		interrupts = <0 106 0x4>,
> > +			     <0 107 0x4>,
> > +			     <0 95 0x4>,
> > +			     <0 97 0x4>;
> > +	};
> 
> You should have interrupt-affinity here. See
> Documentation/devicetree/bindings/arm/pmu.txt
> 
> Otherwise this looks ok.
> 

Thanks for your correction.

Thanks,
Zhiqiang
