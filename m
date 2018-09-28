From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 28 Sep 2018 12:19:03 +0200
Subject: [PATCH 2/2] arm64: defconfig: enable R8A774C0 SoC
In-Reply-To: <cover.1538124193.git.horms+renesas@verge.net.au>
References: <cover.1538124193.git.horms+renesas@verge.net.au>
Message-ID: <76506880eac66cb1f189a993c39ad0fcba723b99.1538124193.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Enable the Renesas RZ/G2E (R8A774C0) SoC in the ARM64 defconfig.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index cf19fa4c7baf..6838b84c6140 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -50,6 +50,7 @@ CONFIG_ARCH_SEATTLE=y
 CONFIG_ARCH_SYNQUACER=y
 CONFIG_ARCH_RENESAS=y
 CONFIG_ARCH_R8A774A1=y
+CONFIG_ARCH_R8A774C0=y
 CONFIG_ARCH_R8A7795=y
 CONFIG_ARCH_R8A7796=y
 CONFIG_ARCH_R8A77965=y
-- 
2.11.0
