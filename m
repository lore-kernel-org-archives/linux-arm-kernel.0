From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 28 Aug 2015 21:44:19 +0200 (CEST)
Subject: [PATCH v2 1/1] irqchip: imx-gpcv2: Simplify the implementation
In-Reply-To: <CY1PR0301MB08439B2D50D3A2C0EC80D579836E0@CY1PR0301MB0843.namprd03.prod.outlook.com>
References: <1440617755-2942-1-git-send-email-shenwei.wang@freescale.com>
 <alpine.DEB.2.11.1508282110260.15006@nanos>
 <CY1PR0301MB08439B2D50D3A2C0EC80D579836E0@CY1PR0301MB0843.namprd03.prod.outlook.com>
Message-ID: <alpine.DEB.2.11.1508282143310.15006@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 28 Aug 2015, Shenwei Wang wrote:
> > So once again. As you said before nothing is going to use the case where source
> > == NULL, can we please get rid of it?
> 
> It will be used to allocate the memory for the predefined values of
> interrupts for each power Domain. Can we keep it?

If there is a user depending on it, yes. Seems I misread your answer
on that.

Thanks,

	tglx
