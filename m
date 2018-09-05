From: broonie@kernel.org (Mark Brown)
Date: Wed,  5 Sep 2018 12:45:50 +0100 (BST)
Subject: Applied "ASoC: uniphier: change status to orphan" to the asoc tree
In-Reply-To: <20180905083137.23153-1-suzuki.katsuhiro@socionext.com>
Message-ID: <20180905114550.7DF3411229D0@debutante.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: uniphier: change status to orphan

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

>From ae45893f74c72e632cbad882509f12558db2e4f3 Mon Sep 17 00:00:00 2001
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Date: Wed, 5 Sep 2018 17:31:37 +0900
Subject: [PATCH] ASoC: uniphier: change status to orphan

Since I'm leaving from Socionext, I'll unable to access specification
documents of this hardware (these are not public). So change the
state to orphan until someone will maintain this driver.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fc711d23dc83..5ee6b45248e5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13159,9 +13159,8 @@ F:	drivers/i2c/busses/i2c-synquacer.c
 F:	Documentation/devicetree/bindings/i2c/i2c-synquacer.txt
 
 SOCIONEXT UNIPHIER SOUND DRIVER
-M:	Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
 L:	alsa-devel at alsa-project.org (moderated for non-subscribers)
-S:	Maintained
+S:	Orphan
 F:	sound/soc/uniphier/
 
 SOEKRIS NET48XX LED SUPPORT
-- 
2.19.0.rc1
