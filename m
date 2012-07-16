From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 16 Jul 2012 15:57:28 +0200
Subject: [PATCH 7/9] Input: ab8500-ponkey: Create AB8500 domain IRQ mapping
In-Reply-To: <5003C449.6000806@linaro.org>
References: <1341493572-29735-1-git-send-email-lee.jones@linaro.org>
 <4FF6994B.9040801@linaro.org>
 <20120706173957.GA10202@core.coreip.homeip.net>
 <4FFB288D.4080606@linaro.org>
 <20120709201422.GA12242@core.coreip.homeip.net>
 <4FFB40A4.5060505@linaro.org>
 <20120709204620.GA12692@core.coreip.homeip.net>
 <4FFB463F.9040201@linaro.org>
 <20120710061757.GB29257@core.coreip.homeip.net>
 <5003C449.6000806@linaro.org>
Message-ID: <20120716135728.GK20652@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Mon, Jul 16, 2012 at 08:35:37AM +0100, Lee Jones wrote:
> > I think it would be best if this got merged through whatever tree that
> > was used to introduce ab8500_irq_get_virq(); otherwise it will have to
> > wait till I resync with mainline sometime in the middle of the next
> > release cycle.
> 
> I agree. Sam that's you, patch below. :)
Applied, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
