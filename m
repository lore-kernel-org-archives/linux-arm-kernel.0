From: gwenhael.goavec-merou@armadeus.com (Gwenhael Goavec-Merou)
Date: Sat,  8 Oct 2011 17:19:48 +0200
Subject: [PATCH 1/2] [ARM] mach-types: Re-add apf9328
Message-ID: <1318087189-22977-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
---
 arch/arm/tools/mach-types |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
index fff68d0..07811a7 100644
--- a/arch/arm/tools/mach-types
+++ b/arch/arm/tools/mach-types
@@ -188,6 +188,7 @@ omap_2430sdp		MACH_OMAP_2430SDP	OMAP_2430SDP		900
 davinci_evm		MACH_DAVINCI_EVM	DAVINCI_EVM		901
 palmz72			MACH_PALMZ72		PALMZ72			904
 nxdb500			MACH_NXDB500		NXDB500			905
+apf9328			MACH_APF9328		APF9328			906
 palmt5			MACH_PALMT5		PALMT5			917
 palmtc			MACH_PALMTC		PALMTC			918
 omap_apollon		MACH_OMAP_APOLLON	OMAP_APOLLON		919
-- 
1.7.3.4
