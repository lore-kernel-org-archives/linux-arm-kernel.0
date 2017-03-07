From: linucherian@gmail.com (linucherian at gmail.com)
Date: Tue,  7 Mar 2017 11:22:43 +0530
Subject: [PATCH V3 3/4] KVM: arm/arm64: Remove KVM_PRIVATE_MEM_SLOTS
 definition that are unused
In-Reply-To: <1488865964-17346-1-git-send-email-linucherian@gmail.com>
References: <1488865964-17346-1-git-send-email-linucherian@gmail.com>
Message-ID: <1488865964-17346-4-git-send-email-linucherian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linu Cherian <linu.cherian@cavium.com>

Signed-off-by: Linu Cherian <linu.cherian@cavium.com>
---
 arch/arm/include/asm/kvm_host.h   | 1 -
 arch/arm64/include/asm/kvm_host.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index d5423ab..b9b39f0 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -30,7 +30,6 @@
 #define __KVM_HAVE_ARCH_INTC_INITIALIZED
 
 #define KVM_USER_MEM_SLOTS 32
-#define KVM_PRIVATE_MEM_SLOTS 4
 #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
 #define KVM_HAVE_ONE_REG
 #define KVM_HALT_POLL_NS_DEFAULT 500000
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index e505038..a0409b0 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -31,7 +31,6 @@
 #define __KVM_HAVE_ARCH_INTC_INITIALIZED
 
 #define KVM_USER_MEM_SLOTS 32
-#define KVM_PRIVATE_MEM_SLOTS 4
 #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
 #define KVM_HALT_POLL_NS_DEFAULT 500000
 
-- 
1.9.1
