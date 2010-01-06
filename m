From: arhuaco@freaks-unidos.net (Nelson Castillo)
Date: Wed, 06 Jan 2010 04:41:54 -0500
Subject: [PATCH 2/2] Remove unneeded __init for s3c_nand_set_platdata
In-Reply-To: <20100106094146.17269.6955.stgit@localhost>
References: <20100106094146.17269.6955.stgit@localhost>
Message-ID: <20100106094153.17269.95604.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unneeded __init in function definition.

Signed-off-by: Nelson Castillo <arhuaco@freaks-unidos.net>
---

 arch/arm/plat-s3c/dev-nand.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-s3c/dev-nand.c b/arch/arm/plat-s3c/dev-nand.c
index 84808cc..a1137a7 100644
--- a/arch/arm/plat-s3c/dev-nand.c
+++ b/arch/arm/plat-s3c/dev-nand.c
@@ -79,7 +79,7 @@ static int __init s3c_nand_copy_set(struct s3c2410_nand_set *set)
 	return 0;
 }
 
-void __init s3c_nand_set_platdata(struct s3c2410_platform_nand *nand)
+void s3c_nand_set_platdata(struct s3c2410_platform_nand *nand)
 {
 	struct s3c2410_platform_nand *npd;
 	int size;
