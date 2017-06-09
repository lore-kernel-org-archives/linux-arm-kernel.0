From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 9 Jun 2017 11:43:08 +0100
Subject: [PATCH 25/31] arm64: Add workaround for Cavium Thunder erratum
 30115
In-Reply-To: <20170503104606.19342-26-marc.zyngier@arm.com>
References: <20170503104606.19342-1-marc.zyngier@arm.com>
 <20170503104606.19342-26-marc.zyngier@arm.com>
Message-ID: <20170609104308.GI2186@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 03, 2017 at 11:46:00AM +0100, Marc Zyngier wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Some Cavium Thunder CPUs suffer a problem where a KVM guest may
> inadvertently cause the host kernel to quit receiving interrupts.
> 
> Use the Group-0/1 trapping in order to deal with it.
> 
> [maz]: Adapted patch to the Group-0/1 trapping, reworked commit log
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
