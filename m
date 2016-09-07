From: voker57@gmail.com (Iaroslav Gridin)
Date: Wed, 7 Sep 2016 19:20:26 +0300
Subject: [PATCH] ARM: dts: msm8974: Add definitions for QCE & cryptobam
In-Reply-To: <32148db3-74b8-c81f-9688-b286d9516b9d@mm-sol.com>
References: <20160830153740.13275-1-voker57@gmail.com>
 <32148db3-74b8-c81f-9688-b286d9516b9d@mm-sol.com>
Message-ID: <20160907162025.3t5t6ghposbzc43r@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > +			clocks = <&gcc GCC_CE2_AHB_CLK>,
> > +				 <&gcc GCC_CE2_AXI_CLK>,
> > +				 <&gcc GCC_CE2_CLK>;
> > +			clock-names = "bam_clk", "axi_clk", "core_clk";
> > +			#dma-cells = <1>;
> > +			qcom,ee = <1>;
> > +			qcom,controlled-remotely;
> > +			};
> 
> indentation please.

Similar indentation (tabs then spaces to align) is used all over dts, am I doing it wrong or is
this bad practice?

Example @ line 334:

>				interrupts = <0 8 0x4>,
>					     <0 7 0x4>;
