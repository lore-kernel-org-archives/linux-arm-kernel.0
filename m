From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 10 May 2016 10:00:43 +0100
Subject: [PATCH v3 11/55] KVM: arm/arm64: pmu: abstract access to number
 of SPIs
In-Reply-To: <1462531568-9799-12-git-send-email-andre.przywara@arm.com>
References: <1462531568-9799-1-git-send-email-andre.przywara@arm.com>
 <1462531568-9799-12-git-send-email-andre.przywara@arm.com>
Message-ID: <5731A33B.7040703@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/16 11:45, Andre Przywara wrote:
> Currently the PMU uses a member of the struct vgic_dist directly,
> which not only breaks abstraction, but will fail with the new VGIC.
> Abstract this access in the VGIC header file.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
