From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 17 Dec 2010 16:04:42 -0800
Subject: [PATCH 01/11] ARM: Add SZ_128
In-Reply-To: <1292622090-21896-2-git-send-email-swarren@nvidia.com>
References: <1292622090-21896-1-git-send-email-swarren@nvidia.com>
	<1292622090-21896-2-git-send-email-swarren@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF030FD788B5@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry, resending this so that it reaches the ARM kernel mailing list; I
used an old address last time around.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
CC: linux-arm at lists.arm.linux.org.uk

---
 arch/arm/include/asm/sizes.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/sizes.h b/arch/arm/include/asm/sizes.h
index 4fc1565..98348c3 100644
--- a/arch/arm/include/asm/sizes.h
+++ b/arch/arm/include/asm/sizes.h
@@ -25,6 +25,7 @@

 /* handy sizes */
 #define SZ_16				0x00000010
+#define SZ_128				0x00000080
 #define SZ_256				0x00000100
 #define SZ_512				0x00000200

-- 
1.7.0.4
nvpublic
