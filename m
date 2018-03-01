From: tony@atomide.com (Tony Lindgren)
Date: Thu,  1 Mar 2018 14:16:59 -0800
Subject: [PATCH 05/10] ARM: omap2plus_defconfig: Add SND_OSSEMUL
In-Reply-To: <20180301221704.104530-1-tony@atomide.com>
References: <20180301221704.104530-1-tony@atomide.com>
Message-ID: <20180301221704.104530-6-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have SND_MIXER_OSS and SND_PCM_OSS but they now
depend on SND_OSSEMUL selecting SOUND_OSS_CORE.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -369,6 +369,7 @@ CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
 CONFIG_LOGO=y
 CONFIG_SOUND=m
 CONFIG_SND=m
+CONFIG_SND_OSSEMUL=y
 CONFIG_SND_MIXER_OSS=m
 CONFIG_SND_PCM_OSS=m
 CONFIG_SND_VERBOSE_PRINTK=y
-- 
2.16.2
