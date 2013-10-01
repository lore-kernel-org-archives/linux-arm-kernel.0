From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 01 Oct 2013 19:33:34 +0900
Subject: [PATCH 04/05] ARM: shmobile: Let KZM9D multiplatform boot with KZM9D
 DTB
In-Reply-To: <20131001103255.813.65710.sendpatchset@w520>
References: <20131001103255.813.65710.sendpatchset@w520>
Message-ID: <20131001103334.813.45590.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Let the multiplatform KZM9D support boot with the
legacy DTS for KZM9D as well as the KZM9D reference DTS.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-kzm9d-reference.c |    1 +
 1 file changed, 1 insertion(+)

--- 0001/arch/arm/mach-shmobile/board-kzm9d-reference.c
+++ work/arch/arm/mach-shmobile/board-kzm9d-reference.c	2013-09-27 11:32:00.000000000 +0900
@@ -33,6 +33,7 @@ static void __init kzm9d_add_standard_de
 }
 
 static const char *kzm9d_boards_compat_dt[] __initdata = {
+	"renesas,kzm9d",
 	"renesas,kzm9d-reference",
 	NULL,
 };
