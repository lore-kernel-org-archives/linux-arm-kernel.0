From: jamie@jamieiles.com (Jamie Iles)
Date: Sat, 17 Dec 2011 13:42:33 +0000
Subject: [PATCHv2 1/5] ARM: picoxcell: remove mach/memory.h
In-Reply-To: <1324129357-16030-1-git-send-email-jamie@jamieiles.com>
References: <1324129357-16030-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1324129357-16030-2-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mach/memory.h is no longer required for simple platforms so remove it
for picoxcell.

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/mach-picoxcell/include/mach/memory.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)
 delete mode 100644 arch/arm/mach-picoxcell/include/mach/memory.h

diff --git a/arch/arm/mach-picoxcell/include/mach/memory.h b/arch/arm/mach-picoxcell/include/mach/memory.h
deleted file mode 100644
index 40a8c17..0000000
--- a/arch/arm/mach-picoxcell/include/mach/memory.h
+++ /dev/null
@@ -1 +0,0 @@
-/* empty */
-- 
1.7.5.4
