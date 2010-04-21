From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Wed, 21 Apr 2010 22:49:08 +0400
Subject: [PATCH 1/2] SA1100: fix wrong CPU type for h3100 and h3600
In-Reply-To: <1271875749-2891-1-git-send-email-mad_soft@inbox.ru>
References: <1271875749-2891-1-git-send-email-mad_soft@inbox.ru>
Message-ID: <1271875749-2891-2-git-send-email-mad_soft@inbox.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

They have StrongARM SA1110, not SA1100.

Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
---
 arch/arm/mach-sa1100/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-sa1100/Kconfig b/arch/arm/mach-sa1100/Kconfig
index b17d52f..fd4c52b 100644
--- a/arch/arm/mach-sa1100/Kconfig
+++ b/arch/arm/mach-sa1100/Kconfig
@@ -57,7 +57,7 @@ config SA1100_COLLIE
 config SA1100_H3100
 	bool "Compaq iPAQ H3100"
 	select HTC_EGPIO
-	select CPU_FREQ_SA1100
+	select CPU_FREQ_SA1110
 	help
 	  Say Y here if you intend to run this kernel on the Compaq iPAQ
 	  H3100 handheld computer.  Information about this machine and the
@@ -68,7 +68,7 @@ config SA1100_H3100
 config SA1100_H3600
 	bool "Compaq iPAQ H3600/H3700"
 	select HTC_EGPIO
-	select CPU_FREQ_SA1100
+	select CPU_FREQ_SA1110
 	help
 	  Say Y here if you intend to run this kernel on the Compaq iPAQ
 	  H3600 handheld computer.  Information about this machine and the
-- 
1.7.0.4
