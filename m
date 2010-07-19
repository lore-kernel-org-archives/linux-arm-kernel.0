From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 19 Jul 2010 18:06:54 +0800
Subject: [GIT PULL] pxa fixes for 2.6.35-rc5
Message-ID: <AANLkTilwLQewOq-NVAif4BLqOXx-Oe3YiZxOZvb-1rq7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1c5474a65bf15a4cb162dfff86d6d0b5a08a740c:

  Linux 2.6.35-rc5 (2010-07-12 14:55:33 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git fix

Eric Miao (3):
      [ARM] pxa/corgi: fix MMC/SD card detection failure
      [ARM] pxa: fix incorrect order of AC97 reset pin configs
      [ARM] pxa: fix incorrect CONFIG_CPU_PXA27x to CONFIG_PXA27x

Marek Vasut (2):
      [ARM] pxa: cpufreq-pxa2xx: fix DRI recomputation routine
      [ARM] pxa: fix frequency scaling for pcmcia/pxa2xx_base

pieterg (1):
      [ARM] pxa/colibri-pxa300: fix AC97 init
