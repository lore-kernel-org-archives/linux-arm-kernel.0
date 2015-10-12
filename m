From: xuwei5@hisilicon.com (Wei Xu)
Date: Mon, 12 Oct 2015 15:51:23 +0100
Subject: [GIT PULL]Hisilicon ARMv7 based SoCs DT updates for V4.4
Message-ID: <561BC8EB.4090505@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Hi Olof, Hi Kevin,

Please help to pull the following changes.
Thanks!

Best Regards,
Wei

---

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://github.com/hisilicon/linux-hisi.git tags/hisi-soc-dt-for-4.4

for you to fetch changes up to 14317946d1da07424dec5d6be3459c393bdf578d:

  ARM: hisilicon: DT: Drop console= and earlyprintk bootargs parameter (2015-10-09 17:05:57 +0100)

----------------------------------------------------------------
ARM: DT: Hisilicon SoC DT updates for 4.4

- Drop console= and earlyprintk bootargs parameter in hisilicon armv7 dts

----------------------------------------------------------------
Wei Xu (1):
      ARM: hisilicon: DT: Drop console= and earlyprintk bootargs parameter

 arch/arm/boot/dts/hi3620-hi4511.dts  | 3 ++-
 arch/arm/boot/dts/hisi-x5hd2-dkb.dts | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)
