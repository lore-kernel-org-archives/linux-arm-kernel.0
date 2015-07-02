From: punnaiah.choudary.kalluri@xilinx.com (Punnaiah Choudary Kalluri)
Date: Thu, 2 Jul 2015 02:33:14 +0000
Subject: macb: zynq: why is SG disabled?
In-Reply-To: <55941D80.2090904@atmel.com>
References: <559403E3.3050900@certsign.ro> <55941D80.2090904@atmel.com>
Message-ID: <03CA77BA8AF6F1469AEDFBDA1322A7B7495B9EE3@XAP-PVEXMBX02.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolae and Cyrille,

   SG feature was not tested for Zynq using macb driver but tested it using the
 emacps Driver in Xilinx tree (this driver is deprecated recently)

We will test and enable this feature in driver for Zynq.

Regards,
Punnaiah

> -----Original Message-----
> From: Cyrille Pitchen [mailto:cyrille.pitchen at atmel.com]
> Sent: Wednesday, July 01, 2015 10:34 PM
> To: Nicolae Rosia; Michal Simek; Punnaiah Choudary Kalluri;
> netdev at vger.kernel.org; Nicolas Ferre; linux-arm-kernel at lists.infradead.org
> Subject: Re: macb: zynq: why is SG disabled?
> 
> Le 01/07/2015 17:14, Nicolae Rosia a ?crit :
> > Hello,
> >
> > After reading the GEM part of Zynq7000 Technical Reference Manual [0], I
> think that SG should be supported.
> > Is there a reason why SG is disabled in macb for Zynq?
> >
> > Best regards,
> > Nicolae Rosia
> 
> Hi Nicolae,
> 
> when the scatter-gather patch was introduced, the feature was enabled only
> on tested boards to avoid regressions on other boards.
> So SG is enabled on sama5d4x and sama5d2x SoCs. SG is disabled on purpose
> on sama5d3x.
> 
> For Zynq, I think the feature is still disabled just because it has never been
> tested.
> 
> Best regards,
> 
> Cyrille
