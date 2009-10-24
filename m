From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Sun, 25 Oct 2009 00:04:00 +0400
Subject: [PATCH 02/20] SA1100: h3100/h3600: remove dead links from Kconfig
	help text
In-Reply-To: <1256414658-22611-2-git-send-email-mad_soft@inbox.ru>
References: <1256414658-22611-1-git-send-email-mad_soft@inbox.ru>
	<1256414658-22611-2-git-send-email-mad_soft@inbox.ru>
Message-ID: <1256414658-22611-3-git-send-email-mad_soft@inbox.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
---
 arch/arm/mach-sa1100/Kconfig |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-sa1100/Kconfig b/arch/arm/mach-sa1100/Kconfig
index 4e5c07f..854768f 100644
--- a/arch/arm/mach-sa1100/Kconfig
+++ b/arch/arm/mach-sa1100/Kconfig
@@ -59,7 +59,6 @@ config SA1100_H3100
 	  Linux port to this machine can be found at:
 
 	  <http://www.handhelds.org/Compaq/index.html#iPAQ_H3100>
-	  <http://www.compaq.com/products/handhelds/pocketpc/>
 
 config SA1100_H3600
 	bool "Compaq iPAQ H3600/H3700"
@@ -69,7 +68,6 @@ config SA1100_H3600
 	  Linux port to this machine can be found at:
 
 	  <http://www.handhelds.org/Compaq/index.html#iPAQ_H3600>
-	  <http://www.compaq.com/products/handhelds/pocketpc/>
 
 config SA1100_BADGE4
 	bool "HP Labs BadgePAD 4"
-- 
1.6.5.1.63.ga9d7.dirty
