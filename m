From: rklein@nvidia.com (rklein at nvidia.com)
Date: Thu, 10 Feb 2011 17:26:56 -0800
Subject: [PATCH] arm: update gitignore file
Message-ID: <1297387616-29390-1-git-send-email-rklein@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rhyland Klein <rklein@nvidia.com>

Updating the .gitignore file to ignore 3 files that are always created in
manual builds to cleanup git status results.

Signed-off-by: Rhyland Klein <rklein@nvidia.com>
---
 arch/arm/boot/compressed/.gitignore |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/compressed/.gitignore b/arch/arm/boot/compressed/.gitignore
index ab204db..c52a6dd 100644
--- a/arch/arm/boot/compressed/.gitignore
+++ b/arch/arm/boot/compressed/.gitignore
@@ -1,3 +1,6 @@
 font.c
 piggy.gz
 vmlinux.lds
+lib1funcs.S
+piggy.gzip
+vmlinux
-- 
1.7.0.4
