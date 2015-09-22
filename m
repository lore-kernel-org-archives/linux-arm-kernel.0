From: B48286@freescale.com (Hou Zhiqiang)
Date: Tue, 22 Sep 2015 09:51:57 +0000
Subject: [PATCH 6/6] dts/ls1043a: add LS1043ARDB board support
In-Reply-To: <1442877225.19102.207.camel@freescale.com>
References: <1442838158-2964-1-git-send-email-B48286@freescale.com>
 <1442838158-2964-7-git-send-email-B48286@freescale.com>
 <1442877225.19102.207.camel@freescale.com>
Message-ID: <CY1PR0301MB0780643BCCE3A5C6BAEA22218B450@CY1PR0301MB0780.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Scott,

> -----Original Message-----
> From: Wood Scott-B07421
> Sent: 2015?9?22? 7:14
> To: Hou Zhiqiang-B48286
> Cc: linux-arm-kernel at lists.infradead.org; catalin.marinas at arm.com;
> will.deacon at arm.com; linux-i2c at vger.kernel.org; linux-
> watchdog at vger.kernel.org; linux-doc at vger.kernel.org; linux-
> clk at vger.kernel.org; wsa at the-dreams.de; wim at iguana.be; corbet at lwn.net;
> mturquette at baylibre.com; sboyd at codeaurora.org; Hu Mingkai-B21284; Xie
> Shaohui-B21989; Song Wenbin-B53747; Sharma Bhupesh-B45370; Li Yang-Leo-
> R58472
> Subject: Re: [PATCH 6/6] dts/ls1043a: add LS1043ARDB board support
> 
> On Mon, 2015-09-21 at 20:22 +0800, Zhiqiang Hou wrote:
> 
> > +             cpld: board-control at 2,0 {
> > +                     compatible = "fsl,ls1043ardb-cpld", "simple-bus";
> > +                     reg = <0x2 0x0 0x0000100>;
> > +             };
> 
> Again, why "simple-bus"?

Thanks and will remove it in v2.

Thanks,
Zhiqiang
