From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 20 Sep 2016 10:50:46 +0100
Subject: [PATCH v6 4/7] arm/arm64: vgic-new: Define required GICv3 reg
 definitions
In-Reply-To: <1474351965-11586-5-git-send-email-vijay.kilari@gmail.com>
References: <1474351965-11586-1-git-send-email-vijay.kilari@gmail.com>
 <1474351965-11586-5-git-send-email-vijay.kilari@gmail.com>
Message-ID: <57E10676.9080509@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/09/16 07:12, vijay.kilari at gmail.com wrote:
> From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
> 
> Define register definitions for ICH_VMCR_EL2, ICC_CTLR_EL1 and
> ICH_VTR_EL2, ICC_BPR0_EL1, ICC_BPR1_EL1 registers.
> 
> Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@cavium.com>

$SUBJECT should report "irqchip/gic-v3: Add missing system register
definitions", or something similar.

Also, please drop this "vgic-new", as there is no vgic-old anymore.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
