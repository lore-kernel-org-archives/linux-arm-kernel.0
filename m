From: npavel@mini-box.com (Nicu Pavel)
Date: Mon, 31 Oct 2011 16:56:50 +0200
Subject: [PATCH 3/3] Add picosam9g45 board to Makefile
In-Reply-To: <1320073010-19549-1-git-send-email-npavel@mini-box.com>
References: <1320073010-19549-1-git-send-email-npavel@mini-box.com>
Message-ID: <1320073010-19549-3-git-send-email-npavel@mini-box.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Nicu Pavel <npavel@mini-box.com>
---
 arch/arm/mach-at91/Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index bf57e8b..ad1950d 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -72,6 +72,7 @@ obj-$(CONFIG_MACH_GSIA18S)	+= board-gsia18s.o board-stamp9g20.o
 obj-$(CONFIG_MACH_SNAPPER_9260)	+= board-snapper9260.o
 
 # AT91SAM9G45 board-specific support
+obj-$(CONFIG_MACH_MINIBOXPICOSAM9G45) += board-picosam9g45.o
 obj-$(CONFIG_MACH_AT91SAM9M10G45EK) += board-sam9m10g45ek.o
 
 # AT91CAP9 board-specific support
-- 
1.7.1
