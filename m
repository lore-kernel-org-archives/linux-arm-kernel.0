From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 30 Jan 2012 17:46:14 +0000
Subject: [PATCH] ARM: devicetree: Add .dtb files to arch/arm/boot/.gitignore
Message-ID: <1327945574-7977-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Compiled device tree blobs shouldn't be committed in the kernel
tree, so ideally git should ignore them.

This patch will enable ignoring of any .dtb files which appear in
arch/arm/boot/

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/boot/.gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/.gitignore b/arch/arm/boot/.gitignore
index ce1c5ff..3c79f85 100644
--- a/arch/arm/boot/.gitignore
+++ b/arch/arm/boot/.gitignore
@@ -3,3 +3,4 @@ zImage
 xipImage
 bootpImage
 uImage
+*.dtb
-- 
1.7.4.1
