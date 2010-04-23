From: mroth@nessie.de (Michael Roth)
Date: Fri, 23 Apr 2010 11:38:18 +0200
Subject: [PATCH] [ARM] .gitignore: Ignore piggy.lzo, lib1funcs.S and vmlinux
Message-ID: <1272015498-10749-1-git-send-email-mroth@nessie.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit e7db7b4270ed2a606b8c0b5f944a5f92ade0e84c added LZO compressed
kernels, lib1funcs.S is copied from the appropriate ARM sub-arch
and vmlinux is the obvious fruit of all efforts.

Signed-off-by: Michael Roth <mroth@nessie.de>
---
 arch/arm/boot/compressed/.gitignore |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/compressed/.gitignore b/arch/arm/boot/compressed/.gitignore
index ab204db..6dac3d0 100644
--- a/arch/arm/boot/compressed/.gitignore
+++ b/arch/arm/boot/compressed/.gitignore
@@ -1,3 +1,6 @@
 font.c
+lib1funcs.S
 piggy.gz
+piggy.lzo
+vmlinux
 vmlinux.lds
-- 
1.6.4.4
