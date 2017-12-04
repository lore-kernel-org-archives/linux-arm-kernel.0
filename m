From: broonie@kernel.org (Mark Brown)
Date: Mon, 04 Dec 2017 18:48:24 +0000
Subject: Applied "MAINTAINERS: add entries for UniPhier ASoC sound drivers" to
 the asoc tree
In-Reply-To: <20171122114321.29196-8-suzuki.katsuhiro@socionext.com>
Message-ID: <E1eLvmy-0000Gd-N2@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   MAINTAINERS: add entries for UniPhier ASoC sound drivers

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 576f8f46e7c923f830dfa61924ad547447399b05 Mon Sep 17 00:00:00 2001
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Date: Wed, 22 Nov 2017 20:43:20 +0900
Subject: [PATCH] MAINTAINERS: add entries for UniPhier ASoC sound drivers

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa71ab52fd76..55ae8ea8722a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12581,6 +12581,12 @@ F:	include/media/soc*
 F:	drivers/media/i2c/soc_camera/
 F:	drivers/media/platform/soc_camera/
 
+SOCIONEXT UNIPHIER SOUND DRIVER
+M:	Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
+L:	alsa-devel at alsa-project.org (moderated for non-subscribers)
+S:	Maintained
+F:	sound/soc/uniphier/
+
 SOEKRIS NET48XX LED SUPPORT
 M:	Chris Boot <bootc@bootc.net>
 S:	Maintained
-- 
2.15.0
