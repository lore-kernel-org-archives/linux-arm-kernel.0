From: fathi.boudra@linaro.org (Fathi Boudra)
Date: Wed, 21 Aug 2013 00:02:40 +0300
Subject: [PATCH 0/3] ARM: vexpress_defconfig: Allow to boot using a regular
 filesystem on SD card
Message-ID: <1377032563-4502-1-git-send-email-fathi.boudra@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vexpress_defconfig is known broken on some use-cases. This serie of
patches allow to boot test Versatile Express using a regular filesystem
on SD card.

Fathi Boudra (3):
  ARM: vexpress_defconfig: Enable and automount devtmpfs filesystem
  ARM: vexpress_defconfig: Enable voltage regulator support
  ARM: vexpress_defconfig: Enable ext4 filesystem

 arch/arm/configs/vexpress_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

-- 
1.8.1.2
