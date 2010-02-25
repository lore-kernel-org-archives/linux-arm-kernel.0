From: saaguirre@ti.com (Sergio Aguirre)
Date: Thu, 25 Feb 2010 09:55:45 -0600
Subject: [PATCH] arm: Fix .gitignore for boot/compressed folder
Message-ID: <1267113345-18426-1-git-send-email-saaguirre@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This should complements changes done in:

  commit e7db7b4270ed2a606b8c0b5f944a5f92ade0e84c
  Author: Albin Tonnerre <albin.tonnerre@free-electrons.com>
  Date:   Fri Jan 8 14:42:43 2010 -0800

      arm: add support for LZO-compressed kernels

It missed to do the respective changes in '.gitignore' file.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/boot/compressed/.gitignore |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/compressed/.gitignore b/arch/arm/boot/compressed/.gitignore
index ab204db..bb984af 100644
--- a/arch/arm/boot/compressed/.gitignore
+++ b/arch/arm/boot/compressed/.gitignore
@@ -1,3 +1,5 @@
 font.c
-piggy.gz
+piggy.gzip
+piggy.lzo
+lib1funcs.S
 vmlinux.lds
-- 
1.6.3.3
