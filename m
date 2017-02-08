From: linucherian@gmail.com (linucherian at gmail.com)
Date: Wed,  8 Feb 2017 12:45:39 +0530
Subject: [PATCH V2 0/2] KVM: arm64: Increase number of user memslots
Message-ID: <1486538141-30627-1-git-send-email-linucherian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linu Cherian <linu.cherian@cavium.com>

v1 -> v2:
- Enabling KVM_CAP_NR_MEMSLOTS for arm/arm64 moved to separate patch.
- Updated commit message so that what is reported to userspace is explicit. 

Linu Cherian (2):
  KVM: arm/arm64: Enable KVM_CAP_NR_MEMSLOTS on arm/arm64
  KVM: arm64: Increase number of user memslots to 508

 arch/arm/kvm/arm.c                | 3 +++
 arch/arm64/include/asm/kvm_host.h | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
1.9.1
