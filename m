From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 11 Jul 2018 11:59:06 +0530
Subject: [GIT PULL 3/3] DaVinci defconfig updates for v4.19
In-Reply-To: <20180711062906.22865-1-nsekhar@ti.com>
References: <20180711062906.22865-1-nsekhar@ti.com>
Message-ID: <20180711062906.22865-3-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.19/defconfig

for you to fetch changes up to 17b98aadcedc823312bdc3641deae873027063bf:

  ARM: davinci_all_defconfig: Enable Bluetooth (2018-06-29 19:26:10 +0530)

----------------------------------------------------------------
DaVinci defconfig updates for v4.19
-----------------------------------

* Enable support for PWM backight and bluetooth
* Remove some vestiges of mach-davinci private clock implementation.

----------------------------------------------------------------
Adam Ford (1):
      ARM: davinci_all_defconfig: set CONFIG_BACKLIGHT_PWM=m

David Lechner (2):
      ARM: davinci_all_defconfig: remove CONFIG_DAVINCI_RESET_CLOCKS
      ARM: davinci_all_defconfig: Enable Bluetooth

 arch/arm/configs/davinci_all_defconfig | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)
