From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Tue, 08 Jan 2013 13:40:13 -0500
Subject: [PATCH v5 14/14] KVM: ARM: Add maintainer entry for KVM/ARM
In-Reply-To: <20130108183811.46302.58543.stgit@ubuntu>
References: <20130108183811.46302.58543.stgit@ubuntu>
Message-ID: <20130108184013.46302.71184.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an entry in the MAINTAINERS file for KVM/ARM.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 MAINTAINERS |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fa309ab..8349bac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4445,6 +4445,14 @@ F:	arch/s390/include/asm/kvm*
 F:	arch/s390/kvm/
 F:	drivers/s390/kvm/
 
+KERNEL VIRTUAL MACHINE (KVM) FOR ARM
+M:	Christoffer Dall <christofferdall@gmail.com>
+L:	kvmarm at lists.cs.columbia.edu
+W:	http://http://systems.cs.columbia.edu/projects/kvm-arm
+S:	Supported
+F:	arch/arm/include/asm/kvm*
+F:	arch/arm/kvm/
+
 KEXEC
 M:	Eric Biederman <ebiederm@xmission.com>
 W:	http://kernel.org/pub/linux/utils/kernel/kexec/
