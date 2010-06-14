From: konkers@android.com (Erik Gilling)
Date: Mon, 14 Jun 2010 14:10:25 -0700
Subject: [PATCH v3 09/11] [ARM] tegra: add MAINTAINERS entry
In-Reply-To: <1276549827-2688-9-git-send-email-konkers@android.com>
References: <1271198563-10424-1-git-send-email-konkers@android.com>
	<1276549827-2688-1-git-send-email-konkers@android.com>
	<1276549827-2688-2-git-send-email-konkers@android.com>
	<1276549827-2688-3-git-send-email-konkers@android.com>
	<1276549827-2688-4-git-send-email-konkers@android.com>
	<1276549827-2688-5-git-send-email-konkers@android.com>
	<1276549827-2688-6-git-send-email-konkers@android.com>
	<1276549827-2688-7-git-send-email-konkers@android.com>
	<1276549827-2688-8-git-send-email-konkers@android.com>
	<1276549827-2688-9-git-send-email-konkers@android.com>
Message-ID: <1276549827-2688-10-git-send-email-konkers@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Erik Gilling <konkers@android.com>
Signed-off-by: Colin Cross <ccross@android.com>
Acked-by: Olof Johansson <olof@lixom.net>
---
 MAINTAINERS |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 67accd7..7cc831a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5520,6 +5520,15 @@ W:	http://tcp-lp-mod.sourceforge.net/
 S:	Maintained
 F:	net/ipv4/tcp_lp.c
 
+TEGRA SUPPORT
+M:	Colin Cross <ccross@android.com>
+M:	Erik Gilling <konkers@android.com>
+M:	Olof Johansson <olof@lixom.net>
+L:	linux-tegra at vger.kernel.org
+T:	git git://android.git.kernel.org/kernel/tegra.git
+S:	Supported
+F:	arch/arm/mach-tegra
+
 TEHUTI ETHERNET DRIVER
 M:	Alexander Indenbaum <baum@tehutinetworks.net>
 M:	Andy Gospodarek <andy@greyhouse.net>
-- 
1.6.5.6
