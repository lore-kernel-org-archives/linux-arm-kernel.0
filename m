From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 18 Feb 2014 14:46:30 +0800
Subject: [PATCH 4/5] ARM: prima2: rtciobrg: fix the typo about license
In-Reply-To: <1392705991-29967-1-git-send-email-21cnbao@gmail.com>
References: <1392705991-29967-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1392705991-29967-5-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

we are marking GPL v2 in head comments, but MODULE_LICENSE is declaring GPL.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/mach-prima2/rtciobrg.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-prima2/rtciobrg.c b/arch/arm/mach-prima2/rtciobrg.c
index 9f2da2e..a17c88b 100644
--- a/arch/arm/mach-prima2/rtciobrg.c
+++ b/arch/arm/mach-prima2/rtciobrg.c
@@ -137,4 +137,4 @@ postcore_initcall(sirfsoc_rtciobrg_init);
 MODULE_AUTHOR("Zhiwu Song <zhiwu.song@csr.com>, "
 		"Barry Song <baohua.song@csr.com>");
 MODULE_DESCRIPTION("CSR SiRFprimaII rtc io bridge");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
-- 
1.7.5.4
