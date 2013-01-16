From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Wed, 16 Jan 2013 12:59:25 -0500
Subject: [PATCH v6 15/15] KVM: ARM: Add maintainer entry for KVM/ARM
In-Reply-To: <20130116175716.29147.15348.stgit@ubuntu>
References: <20130116175716.29147.15348.stgit@ubuntu>
Message-ID: <20130116175925.29147.40357.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an entry in the MAINTAINERS file for KVM/ARM.

Cc: Russell King <linux@arm.linux.org.uk>
Reviewed-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 MAINTAINERS |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 915564e..70e5a10 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4474,6 +4474,14 @@ F:	arch/s390/include/asm/kvm*
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
