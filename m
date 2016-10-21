From: david@lechnology.com (David Lechner)
Date: Fri, 21 Oct 2016 13:36:54 -0500
Subject: [PATCH 2/5] ARM: davinci: Don't append git rev to local version
In-Reply-To: <1477075018-20176-1-git-send-email-david@lechnology.com>
References: <1477075018-20176-1-git-send-email-david@lechnology.com>
Message-ID: <1477075018-20176-3-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the davinci default configuration, don't append the git revision to
the local kernel version by. This seems like the more desirable default
value.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/configs/davinci_all_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index a2f89a3..9254609 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -1,3 +1,4 @@
+# CONFIG_LOCALVERSION_AUTO is not set
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
-- 
2.7.4
