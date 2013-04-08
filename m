From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  8 Apr 2013 16:47:17 +0100
Subject: [PATCH 0/2] ARM: KVM: pre-KVM/arm64 patches
Message-ID: <1365436039-29564-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series contains two small changes to KVM/ARM, in preparation for
the arm64 patches. None of these changes actually affect the 32bit
implementation.

This has been tested on both arm (VE TC2) and arm64 (Foundation Model).

Marc Zyngier (2):
  ARM: KVM: add architecture specific hook for capabilities
  ARM: KVM: promote vfp_host pointer to generic host cpu context

 arch/arm/include/asm/kvm_host.h | 13 ++++++++++---
 arch/arm/kernel/asm-offsets.c   |  2 +-
 arch/arm/kvm/arm.c              | 30 +++++++++++++++---------------
 3 files changed, 26 insertions(+), 19 deletions(-)

-- 
1.8.1.4
