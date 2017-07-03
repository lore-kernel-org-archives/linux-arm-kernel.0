From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 3 Jul 2017 15:15:57 +0100
Subject: [PATCH] irqchip: constify irq_domain_ops
In-Reply-To: <1499091004-20909-1-git-send-email-yamada.masahiro@socionext.com>
References: <1499091004-20909-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <b5e49daf-efe5-b5b3-6abe-8c9ad4afc0ff@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/07/17 15:10, Masahiro Yamada wrote:
> The core framework does not modify irq_domain_ops, so those driver
> data can be qualified with 'const'.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Please check the current next, which has quite a few (if not all) of
these already.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
