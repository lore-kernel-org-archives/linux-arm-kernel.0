From: weber@corscience.de (Thomas Weber)
Date: Wed, 16 Nov 2011 16:56:52 +0100
Subject: [PATCH Resend] ARM: OMAP2+: Remove empty io.h
Message-ID: <1321459012-15418-1-git-send-email-weber@corscience.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The file arch/arm/mach-omap2/io.h is empty, so we can remove it.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 0 files changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/io.h

diff --git a/arch/arm/mach-omap2/io.h b/arch/arm/mach-omap2/io.h
deleted file mode 100644
index e69de29..0000000
-- 
1.7.8.rc1
