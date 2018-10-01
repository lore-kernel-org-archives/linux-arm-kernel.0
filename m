From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  1 Oct 2018 14:06:54 +0100
Subject: [PATCH 0/2] KVM: arm64: Dynamic IPA cosmetic fixups
Message-ID: <20181001130656.36999-1-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's a couple of tiny cleanups I'd like to queue on top of Suzuki's
series. They are purely cosmetic, and just aim at making the code
slightly more readable.

If nobody shouts, I'll stack them on top.

Thanks,

	M.

Marc Zyngier (2):
  KVM: arm/arm64: Rename kvm_arm_config_vm to kvm_arm_setup_stage2
  KVM: arm64: Drop __cpu_init_stage2 on the VHE path

 arch/arm/include/asm/kvm_host.h   |  6 +++++-
 arch/arm64/include/asm/kvm_arm.h  |  2 +-
 arch/arm64/include/asm/kvm_host.h |  2 +-
 arch/arm64/kvm/reset.c            |  2 +-
 virt/kvm/arm/arm.c                | 12 +++---------
 5 files changed, 11 insertions(+), 13 deletions(-)

-- 
2.19.0
