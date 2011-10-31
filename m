From: npavel@mini-box.com (Nicu Pavel)
Date: Mon, 31 Oct 2011 17:53:15 +0200
Subject: [PATCH v2 2/3] Add kernel configuration option for picosam9g45 board
In-Reply-To: <1320076396-6233-1-git-send-email-npavel@mini-box.com>
References: <1320076396-6233-1-git-send-email-npavel@mini-box.com>
Message-ID: <1320076396-6233-2-git-send-email-npavel@mini-box.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Nicu Pavel <npavel@mini-box.com>
---
 arch/arm/mach-at91/Kconfig |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 2248467..419295a 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -400,6 +400,12 @@ if ARCH_AT91SAM9G45
 
 comment "AT91SAM9G45 Board Type"
 
+config MACH_MINIBOXPICOSAM9G45
+	bool "Mini-Box.com picoSAM9G45 board"
+	help
+	  Select this if you are using Mini-Box.com picoSAM9G45 Board
+	  <http://arm.mini-box.com>
+
 config MACH_AT91SAM9M10G45EK
 	bool "Atmel AT91SAM9M10G45-EK Evaluation Kits"
 	help
-- 
1.7.1
