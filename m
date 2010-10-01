From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri,  1 Oct 2010 14:29:26 -0700
Subject: [PATCH 02/47] MAINTAINERS: Add Kevin's e-mail in entry for TI DaVinci
In-Reply-To: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
References: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1285968611-26890-3-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

In absence of Kevin's e-mail address, using get_maintaner.pl in
git-send-email --cc-cmd option is not CCing Kevin at all.

While at it, mark davinci-linux-open-source at linux.davincidsp.com as
a list in line with what is being done for other maintainer entries.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 MAINTAINERS |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 50b8148..35612dd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5247,8 +5247,8 @@ F:	drivers/*/*s3c2410*
 F:	drivers/*/*/*s3c2410*
 
 TI DAVINCI MACHINE SUPPORT
-P:	Kevin Hilman
-M:	davinci-linux-open-source at linux.davincidsp.com
+M:	Kevin Hilman <khilman@deeprootsystems.com>
+L:	davinci-linux-open-source at linux.davincidsp.com (subscribers-only)
 Q:	http://patchwork.kernel.org/project/linux-davinci/list/
 S:	Supported
 F:	arch/arm/mach-davinci
-- 
1.7.2.1
