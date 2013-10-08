From: msalter@redhat.com (Mark Salter)
Date: Tue,  8 Oct 2013 01:10:19 -0400
Subject: [PATCH v2 03/14] arm: select ARCH_MAY_HAVE_PC_PARPORT
In-Reply-To: <1381209030-351-1-git-send-email-msalter@redhat.com>
References: <1381209030-351-1-git-send-email-msalter@redhat.com>
Message-ID: <1381209030-351-4-git-send-email-msalter@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Architectures which support CONFIG_PARPORT_PC should select
ARCH_MAY_HAVE_PC_PARPORT.

Signed-off-by: Mark Salter <msalter@redhat.com>
CC: Russell King <linux@arm.linux.org.uk>
CC: linux-arm-kernel at lists.infradead.org
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1ad6fb6..2734ec1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -5,6 +5,7 @@ config ARM
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAVE_CUSTOM_GPIO_H
+	select ARCH_MAY_HAVE_PC_PARPORT
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select BUILDTIME_EXTABLE_SORT if MMU
 	select CLONE_BACKWARDS
-- 
1.8.3.1
