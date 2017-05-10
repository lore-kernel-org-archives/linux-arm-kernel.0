From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 10 May 2017 14:32:34 +0100
Subject: [PATCH] irqchip/bcm2836: Move SMP startup code to arch/arm
In-Reply-To: <20170510132620.19685-1-marc.zyngier@arm.com>
References: <20170510132620.19685-1-marc.zyngier@arm.com>
Message-ID: <2c3f16ea-8806-9ae8-9bae-02e198a59092@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/05/17 14:26, Marc Zyngier wrote:
> One of the RPi-2/3 irqchip's key features is that it contains some
> SMP startup code for the 32bit ARM architecture version. The only
> reason I can imagine for this is "RPi is special".
> 
> Let's move this code where it belongs (in the platform support code),
> creating a shared include file for this purpose.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Also:
Fixes: 41f4988cc287 ("irqchip/bcm2836: Add SMP support for the 2836")

	M.
-- 
Jazz is not dead. It just smells funny...
