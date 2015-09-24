From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 24 Sep 2015 15:11:10 +0100
Subject: [PATCH 3/3] irqchip/GICv2m: Fix GICv2m build warning on 32 bits
In-Reply-To: <15cd01d0f6a1$bf6577d0$3e306770$@samsung.com>
References: <1442142873-20213-1-git-send-email-marc.zyngier@arm.com>
 <1442142873-20213-4-git-send-email-marc.zyngier@arm.com>
 <15cd01d0f6a1$bf6577d0$3e306770$@samsung.com>
Message-ID: <20150924151110.3bde167e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 24 Sep 2015 11:19:33 +0300
Pavel Fedin <p.fedin@samsung.com> wrote:

>  Hello!
> 
> > From: Pavel Fedin <p.fedin@samsung.com>
> > 
> > After GICv2m was enabled for 32-bit ARM kernel, a warning popped up:
> 
>  Thank you for the cooperation, i'm now back from my vacation.
>  What about the first patch in the series, which actually enables
> GICv2m on 32 bits? I don't see it anywhere, neither there are reviews.

This is a patch that touches arch/arm, so this is Russell that you have
to convince, not me.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
