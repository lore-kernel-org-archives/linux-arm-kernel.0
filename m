From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 19 Sep 2014 22:25:18 +0100
Subject: [PATCH 1/2 V7] irqchip: gic: Add support for multiple MSI for
 ARM64
In-Reply-To: <1411006486-17513-2-git-send-email-suravee.suthikulpanit@amd.com>
 (suravee's message of "Thu, 18 Sep 2014 03:14:45 +0100")
References: <1411006486-17513-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1411006486-17513-2-git-send-email-suravee.suthikulpanit@amd.com>
Message-ID: <8638bnpakh.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 18 2014 at 03:14:45 AM, "suravee.suthikulpanit at amd.com" <suravee.suthikulpanit@amd.com> wrote:
> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>
> This patch implelments the ARM64 version of arch_setup_msi_irqs(),
> which does not return 1 for when PCI_CAP_ID_MSI and nvec > 1.
>
> Cc: Mark Rutland <Mark.Rutland@arm.com>
> Cc: Marc Zyngier <Marc.Zyngier@arm.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Catalin Marinas <Catalin.Marinas@arm.com>
> Cc: Will Deacon <Will.Deacon@arm.com>
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
