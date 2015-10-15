From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 15 Oct 2015 18:39:26 +0100
Subject: [PATCH RFC 4/7] genirq/msi: Make the .prepare callback reusable
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1624783E@lhreml503-mbs>
References: <1444923568-17413-1-git-send-email-marc.zyngier@arm.com>
 <1444923568-17413-5-git-send-email-marc.zyngier@arm.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1624783E@lhreml503-mbs>
Message-ID: <561FE4CE.4090505@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/10/15 18:24, Gabriele Paoloni wrote:
> Hi Marc
> 
> It looks like this patch fails to apply to 4.3-rc5....

Which is by design. Try tip/irq/core.

	M.
-- 
Jazz is not dead. It just smells funny...
