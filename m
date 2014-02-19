From: Li.Xiubo@freescale.com (Li.Xiubo at freescale.com)
Date: Wed, 19 Feb 2014 07:25:43 +0000
Subject: [PATCH 2/4] ARM: dts: Enable SAI ALSA SoC DAI device for Vybrid
 VF610 TOWER board.
In-Reply-To: <20140219070630.GE3010@S2101-09.ap.freescale.net>
References: <1392788323-6092-1-git-send-email-Li.Xiubo@freescale.com>
 <1392788323-6092-3-git-send-email-Li.Xiubo@freescale.com>
 <20140219070630.GE3010@S2101-09.ap.freescale.net>
Message-ID: <ea66b1869211439f96598b54e24e282a@BY2PR03MB505.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > @@ -127,9 +127,27 @@
> >  				VF610_PAD_PTB5__UART1_RX		0x21a1
> >  			>;
> >  		};
> > +
> > +		pinctrl_sai2: sai2grp {
> 
> To sort it alphabetically, the entry should be added before
> pinctrl_uart1.
> 
> > +		      fsl,pins = <
> > +			      VF610_PAD_PTA16__SAI2_TX_BCLK   0x02ed
> > +			      VF610_PAD_PTA18__SAI2_TX_DATA   0x02ee
> > +			      VF610_PAD_PTA19__SAI2_TX_SYNC   0x02ed
> > +			      VF610_PAD_PTA21__SAI2_RX_BCLK   0x02ed
> > +			      VF610_PAD_PTA22__SAI2_RX_DATA   0x02ed
> > +			      VF610_PAD_PTA23__SAI2_RX_SYNC   0x02ed
> > +			      VF610_PAD_PTB18__EXT_AUDIO_MCLK 0x02ed
> 
> Use tabs instead of spaces.
> 
> Shawn
> 

Yes, I'll fix these two issues above.

Thanks,

--
Best Regards,
Xiubo
