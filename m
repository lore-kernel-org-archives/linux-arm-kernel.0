From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 12 Feb 2014 14:03:18 +0000
Subject: [PATCH 8/9] ARM: virt: make mach-virt just a kconfig option
In-Reply-To: <1392153119-23248-9-git-send-email-robherring2@gmail.com>
References: <1392153119-23248-1-git-send-email-robherring2@gmail.com>
 <1392153119-23248-9-git-send-email-robherring2@gmail.com>
Message-ID: <52FB7F26.2040103@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/02/14 21:11, Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
> 
> The mach code for mach-virt is no longer needed, so we can remove all of
> mach-virt except the kconfig entry.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Russell King <linux@arm.linux.org.uk>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
