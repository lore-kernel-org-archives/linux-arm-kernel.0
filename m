From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 23 Oct 2013 15:04:20 +0200
Subject: [PATCH 3/4] mvebu: Dove: Enable cpufreq driver in defconfig
In-Reply-To: <1382533461-31021-1-git-send-email-andrew@lunn.ch>
References: <1382533461-31021-1-git-send-email-andrew@lunn.ch>
Message-ID: <1382533461-31021-3-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add cpufreq to dove_defconfig, so it is built by default.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 arch/arm/configs/dove_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/dove_defconfig b/arch/arm/configs/dove_defconfig
index 1101054..3d92350 100644
--- a/arch/arm/configs/dove_defconfig
+++ b/arch/arm/configs/dove_defconfig
@@ -22,6 +22,8 @@ CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
+CONFIG_CPU_FREQ=y
+CONFIG_CPU_FREQ_GOV_ONDEMAND=y
 CONFIG_VFP=y
 CONFIG_NET=y
 CONFIG_PACKET=y
-- 
1.8.4.rc3
