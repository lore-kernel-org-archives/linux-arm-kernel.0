From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 27 Aug 2015 16:56:18 +0200 (CEST)
Subject: [PATCH v3] irqchip: kill off set_irq_flags usage
In-Reply-To: <CAL_JsqL9EsFpE3j_ud6bvoJ38di+2428mBD2VgQPX8fba=BpdQ@mail.gmail.com>
References: <1438030523-15853-1-git-send-email-robh@kernel.org>
 <1438030523-15853-6-git-send-email-robh@kernel.org>
 <CAL_JsqL9EsFpE3j_ud6bvoJ38di+2428mBD2VgQPX8fba=BpdQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.11.1508271655220.15006@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Aug 2015, Rob Herring wrote:
> Everything except this patch, sh, gpu, and final removal of
> set_irq_flags in arm/arm64 are in -next. There don't appear to be any
> new users either.
> 
> Can you apply this patch and these 2 now so they have some time in -next:
> 
> http://lkml.kernel.org/r/1438030523-15853-11-git-send-email-robh at kernel.org
> http://lkml.kernel.org/r/1438030523-15853-5-git-send-email-robh at kernel.org
> 
> And these 2 toward the end of the merge window once there is no more
> set_irq_flags:
> 
> http://lkml.kernel.org/r/1436711211-18223-13-git-send-email-robh at kernel.org
> http://lkml.kernel.org/r/1436711211-18223-14-git-send-email-robh at kernel.org

Could you please resend these 5 patches to me. Seems I lost some of them.

Thanks,

	tglx
