From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Wed, 22 Jun 2016 15:56:58 +0200
Subject: [PATCH] MAINTAINERS: update STM32 maintainers list
Message-ID: <1466603818-7902-1-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I will have less time to work on STM32 platform, so I propose
Alexandre as co-maintainer.

Alex is working in the STMicroelectronics division in charge of STM32
family, so he will have access to all technical information and
hardware.

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7304d2e37a98..4504331809ac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1723,6 +1723,7 @@ F:	drivers/ata/ahci_st.c
 
 ARM/STM32 ARCHITECTURE
 M:	Maxime Coquelin <mcoquelin.stm32@gmail.com>
+M:	Alexandre Torgue <alexandre.torgue@st.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mcoquelin/stm32.git
-- 
1.9.1
