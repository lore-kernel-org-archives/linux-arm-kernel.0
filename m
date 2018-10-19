From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 19 Oct 2018 13:58:56 +0100
Subject: [PATCH 21/26] arm64: KVM: Remove some extra semicolon in
 kvm_target_cpu
In-Reply-To: <20181019125901.185478-1-marc.zyngier@arm.com>
References: <20181019125901.185478-1-marc.zyngier@arm.com>
Message-ID: <20181019125901.185478-22-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: zhong jiang <zhongjiang@huawei.com>

There are some extra semicolon in kvm_target_cpu, remove it.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/guest.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 07256b08226c..a74f84d09412 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -338,15 +338,15 @@ int __attribute_const__ kvm_target_cpu(void)
 			return KVM_ARM_TARGET_CORTEX_A53;
 		case ARM_CPU_PART_CORTEX_A57:
 			return KVM_ARM_TARGET_CORTEX_A57;
-		};
+		}
 		break;
 	case ARM_CPU_IMP_APM:
 		switch (part_number) {
 		case APM_CPU_PART_POTENZA:
 			return KVM_ARM_TARGET_XGENE_POTENZA;
-		};
+		}
 		break;
-	};
+	}
 
 	/* Return a default generic target */
 	return KVM_ARM_TARGET_GENERIC_V8;
-- 
2.19.1
