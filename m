From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  8 Apr 2013 17:17:34 +0100
Subject: [PATCH v3 32/32] arm64: KVM: MAINTAINERS update
In-Reply-To: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1365437854-30214-33-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Elect myself as the KVM/arm64 maintainer.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 836a618..c6e0170 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4628,6 +4628,15 @@ F:	arch/arm/include/uapi/asm/kvm*
 F:	arch/arm/include/asm/kvm*
 F:	arch/arm/kvm/
 
+KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)
+M:	Marc Zyngier <marc.zyngier@arm.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+L:	kvmarm at lists.cs.columbia.edu
+S:	Maintained
+F:	arch/arm64/include/uapi/asm/kvm*
+F:	arch/arm64/include/asm/kvm*
+F:	arch/arm64/kvm/
+
 KEXEC
 M:	Eric Biederman <ebiederm@xmission.com>
 W:	http://kernel.org/pub/linux/utils/kernel/kexec/
-- 
1.8.1.4
