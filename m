From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 7 Aug 2017 08:41:10 +0100
Subject: [PATCH 3/3] irqchip: bcm2836: Move SMP startup code to arch/arm
In-Reply-To: <1502058731-12462-4-git-send-email-stefan.wahren@i2se.com>
References: <1502058731-12462-1-git-send-email-stefan.wahren@i2se.com>
 <1502058731-12462-4-git-send-email-stefan.wahren@i2se.com>
Message-ID: <0f587b52-d9db-3bbe-968d-66b40fba508c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/08/17 23:32, Stefan Wahren wrote:
> In order to easily provide SMP for BCM2837 on 32-bit and 64-bit
> the SMP startup code was placed in irq-bcm2836. That's not the
> right approach. So move this code where it belongs.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Fixes: 41f4988cc287 ("irqchip/bcm2836: Add SMP support for the 2836")

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

How do you want to get this merged? I can either take it via the irqchip
tree, or you take it via arm-soc. Just let me know.

	M.
-- 
Jazz is not dead. It just smells funny...
