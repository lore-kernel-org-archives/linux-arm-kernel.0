From: baruch@tkos.co.il (Baruch Siach)
Date: Mon,  6 Jul 2015 07:03:37 +0300
Subject: [PATCH] crypto: arm: ignore generated SHA2 assembly files
Message-ID: <e9fad4b90e8d3aac883e2a5ac99b330653bcc354.1436155417.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These files are generated since commits f2f770d74a8d (crypto: arm/sha256 - Add
optimized SHA-256/224, 2015-04-03) and c80ae7ca3726 (crypto: arm/sha512 -
accelerated SHA-512 using ARM generic ASM and NEON, 2015-05-08).

Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/crypto/.gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/crypto/.gitignore b/arch/arm/crypto/.gitignore
index 6231d36b3635..31e1f538df7d 100644
--- a/arch/arm/crypto/.gitignore
+++ b/arch/arm/crypto/.gitignore
@@ -1 +1,3 @@
 aesbs-core.S
+sha256-core.S
+sha512-core.S
-- 
2.1.4
