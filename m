From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Thu, 1 Dec 2011 12:03:16 +0000
Subject: [RFC PATCH 07/11] arm:omap:am33xx: Add irq, dma and module base
 addr to SoC header files
In-Reply-To: <87obvtt66u.fsf@ti.com>
References: <1321809555-13833-1-git-send-email-hvaibhav@ti.com>
 <1321809555-13833-8-git-send-email-hvaibhav@ti.com> <87obvtt66u.fsf@ti.com>
Message-ID: <79CD15C6BA57404B839C016229A409A804762B@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Hilman, Kevin
> Sent: Thursday, December 01, 2011 7:16 AM
> To: Hiremath, Vaibhav
> Cc: linux-omap at vger.kernel.org; tony at atomide.com; paul at pwsan.com; linux-
> arm-kernel at lists.infradead.org; Cousson, Benoit; Mohammed, Afzal
> Subject: Re: [RFC PATCH 07/11] arm:omap:am33xx: Add irq, dma and module
> base addr to SoC header files
> 
> Vaibhav Hiremath <hvaibhav@ti.com> writes:
> 
> > This patch creats seperate irq and dma defination header file
> > and updates the module base addresses required for HWMOD data.
> >
> > Signed-off-by: Afzal Mohammed <afzal@ti.com>
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> These headers/defines should no longer be needed.  Instead, as with
> OMAP4, the raw values are used in the hwmod data (and we'll be moving
> device tree for these values.)
> 
Ok, will clean this up in next version.

Thanks,
Vaibhav

> Kevin
