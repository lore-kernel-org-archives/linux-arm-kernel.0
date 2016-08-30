From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 30 Aug 2016 09:42:45 +0100
Subject: [PATCH] irqchip/gicv3-its: Enable cacheable attribute
 Read-allocate hints
In-Reply-To: <11225da6-559e-c1bd-2ba5-a941595d6532@codeaurora.org>
References: <1468294608-30619-1-git-send-email-shankerd@codeaurora.org>
 <5784A5C8.4080103@arm.com> <5784F188.3010609@codeaurora.org>
 <11225da6-559e-c1bd-2ba5-a941595d6532@codeaurora.org>
Message-ID: <57C54705.4070209@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/08/16 16:35, Shanker Donthineni wrote:
> Marc,
> 
> Are you planning to push this change? I talked to Qualcomm ITS hw team 
> and they told me nice to have this change even though we see a small gain.

Hi Shanker,

As I asked before, I'd like to know what is the actual gain on real HW,
and how you measured it, so that I can try and make sure this doesn't
introduce regressions on other implementations. If it does, then we'll
probably have to quirk it.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
