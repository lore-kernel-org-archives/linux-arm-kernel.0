From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 24 Dec 2015 11:12:38 +0000
Subject: [PATCH 30/31] MAINTAINERS: add git URL for KVM/ARM
In-Reply-To: <1450955559-15639-1-git-send-email-marc.zyngier@arm.com>
References: <1450955559-15639-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1450955559-15639-31-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fengguang Wu <fengguang.wu@intel.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9bff63c..8e92b45 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6102,6 +6102,7 @@ M:	Marc Zyngier <marc.zyngier@arm.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 L:	kvmarm at lists.cs.columbia.edu
 W:	http://systems.cs.columbia.edu/projects/kvm-arm
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git
 S:	Supported
 F:	arch/arm/include/uapi/asm/kvm*
 F:	arch/arm/include/asm/kvm*
-- 
2.1.4
