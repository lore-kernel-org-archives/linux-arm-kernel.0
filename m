From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Fri, 16 Oct 2015 13:07:05 +0000
Subject: [PATCH RFC 4/7] genirq/msi: Make the .prepare callback reusable
In-Reply-To: <561FE4CE.4090505@arm.com>
References: <1444923568-17413-1-git-send-email-marc.zyngier@arm.com>
 <1444923568-17413-5-git-send-email-marc.zyngier@arm.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1624783E@lhreml503-mbs>
 <561FE4CE.4090505@arm.com>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E16248DEC@lhreml503-mbs>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-kernel-owner at vger.kernel.org [mailto:linux-kernel-
> owner at vger.kernel.org] On Behalf Of Marc Zyngier
> Sent: Thursday, October 15, 2015 6:39 PM
> To: Gabriele Paoloni; Thomas Gleixner; Jiang Liu; Jason Cooper
> Cc: majun (F); linux-arm-kernel at lists.infradead.org; linux-
> pci at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH RFC 4/7] genirq/msi: Make the .prepare callback
> reusable
> 
> On 15/10/15 18:24, Gabriele Paoloni wrote:
> > Hi Marc
> >
> > It looks like this patch fails to apply to 4.3-rc5....
> 
> Which is by design. Try tip/irq/core.

Oops sorry, got it!

Thanks, applies ok to tip/irq/core

Gab


> 
> 	M.
> --
> Jazz is not dead. It just smells funny...
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
