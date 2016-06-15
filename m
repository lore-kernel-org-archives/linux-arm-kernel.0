From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 15 Jun 2016 10:00:34 +0100
Subject: [PATCH V6 6/7] irqchip/gicv3-its: Factor out code that might be
 reused for ACPI
In-Reply-To: <1465828873-23498-7-git-send-email-tn@semihalf.com>
References: <1465828873-23498-1-git-send-email-tn@semihalf.com>
 <1465828873-23498-7-git-send-email-tn@semihalf.com>
Message-ID: <20160615100034.3393b90c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 13 Jun 2016 16:41:12 +0200
Tomasz Nowicki <tn@semihalf.com> wrote:

> Firmware agnostic code lands in common functions which do necessary
> domain initialization based on unique domain handler. DT specific
> code goes to DT specific init call.
> 
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
