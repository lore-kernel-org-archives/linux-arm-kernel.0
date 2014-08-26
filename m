From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 26 Aug 2014 17:53:06 +0100
Subject: [PATCH v2 25/26] arm64: get rid of handle_IRQ
In-Reply-To: <1409047421-27649-26-git-send-email-marc.zyngier@arm.com>
References: <1409047421-27649-1-git-send-email-marc.zyngier@arm.com>
 <1409047421-27649-26-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140826165304.GN16482@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 11:03:40AM +0100, Marc Zyngier wrote:
> All the arm64 irqchip drivers have been converted to handle_domain_irq,
> making it possible to remove the handle_IRQ stub entierely.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
