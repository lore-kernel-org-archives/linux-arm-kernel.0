From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 22 Feb 2012 19:18:44 +0000
Subject: [PATCH 1/3] arm: ignore devicetree blobs.
In-Reply-To: <cover.1329936660.git.jason@lakedaemon.net>
References: <cover.1329936660.git.jason@lakedaemon.net>
Message-ID: <3629df9b5b96d3a3a63a34ebf6ddfca2fd72ccfc.1329936660.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
NOTE: This is the first version of this patch, so no change history.

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
1.7.3.4
