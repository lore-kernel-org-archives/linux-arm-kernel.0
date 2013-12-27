From: Li.Xiubo@freescale.com (Li.Xiubo at freescale.com)
Date: Fri, 27 Dec 2013 09:08:13 +0000
Subject: [PATCHv4 2/4] ARM: dts: Add Freescale SAI ALSA SoC Digital
 Audio Interface node for VF610.
In-Reply-To: <20131227085322.GA3367@S2101-09.ap.freescale.net>
References: <1387501387-2151-1-git-send-email-Li.Xiubo@freescale.com>
 <1387501387-2151-2-git-send-email-Li.Xiubo@freescale.com>
 <20131227085322.GA3367@S2101-09.ap.freescale.net>
Message-ID: <4d5402daa3384da795fdb895531e32a6@BY2PR03MB505.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

> > diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
> > index e84d84c..2d6ddd0 100644
> > --- a/arch/arm/boot/dts/vf610.dtsi
> > +++ b/arch/arm/boot/dts/vf610.dtsi
> > @@ -166,6 +166,9 @@
> >  				interrupts = <0 86 0x04>;
> >  				clocks = <&clks VF610_CLK_SAI2>;
> >  				clock-names = "sai";
> > +				dma-names = "tx", "rx";
> > +				dmas = <&edma0 0 VF610_EDMA_MUXID0_SAI2_TX>,
> > +					<&edma0 0 VF610_EDMA_MUXID0_SAI2_RX>;
> 
> Where are these VF610_EDMA_MUXID0_* macros defined?  I cannot find them
> in my tree.
>

Sorry, this is depended on the eDMA driver, which is still doing the upstream
work by another colleague.

I will let you know if the eDMA driver has been merged in.


Thanks,

Best Regards,
Xiubo
 
