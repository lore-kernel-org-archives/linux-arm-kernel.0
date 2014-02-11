From: yao.yuan@freescale.com (Yao Yuan)
Date: Tue, 11 Feb 2014 01:50:14 +0000
Subject: [PATCH v4 0/3] serial: fsl_lpuart: add DMA support
In-Reply-To: <20140127075025.GC4765@S2101-09.ap.freescale.net>
References: <1390363773-24108-1-git-send-email-yao.yuan@freescale.com>
 <20140127075025.GC4765@S2101-09.ap.freescale.net>
Message-ID: <c1c2915231eb4595b89327e589bc521d@BL2PR03MB338.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Shawn

Here I just want the DMA be a selectable property for each board. 
Is it suitable?

> -----Original Message-----
> From: Shawn Guo [mailto:shawn.guo at linaro.org]
> Sent: Monday, January 27, 2014 3:50 PM
> To: Yuan Yao-B46683
> Cc: gregkh at linuxfoundation.org; linux at arm.linux.org.uk; arnd at arndb.de;
> mark.rutland at arm.com; linux-arm-kernel at lists.infradead.org; linux-
> serial at vger.kernel.org
> Subject: Re: [PATCH v4 0/3] serial: fsl_lpuart: add DMA support
> 
> On Wed, Jan 22, 2014 at 12:09:30PM +0800, Yuan Yao wrote:
> > Changed in v4:
> > - Move dma properties from dtsi to dts.
> 
> Why this change?  DMA is a SoC level resource rather than board one.
> 
> Shawn
