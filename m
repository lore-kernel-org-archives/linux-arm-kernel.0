From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 12 Jun 2013 06:08:28 +0900
Subject: [GIT PULL 2/6] s3c24xx DT
Message-ID: <51B791CC.4000405@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

   Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/s3c24xx-dt-1

for you to fetch changes up to 35aca36450e6c3fb3b3fe9ea60a7c4689a219a87:

   ARM: dts: add devicetree support for s3c2416-smdk2416 (2013-05-21 
01:06:12 +0900)

----------------------------------------------------------------
add DT support for s3c2416-smdk2416

----------------------------------------------------------------
Heiko Stuebner (1):
       ARM: dts: add devicetree support for s3c2416-smdk2416

  arch/arm/boot/dts/Makefile              |   1 +
  arch/arm/boot/dts/s3c2416-pinctrl.dtsi  | 173 
++++++++++++++++++++++++++++++++
  arch/arm/boot/dts/s3c2416-smdk2416.dts  |  72 +++++++++++++
  arch/arm/boot/dts/s3c2416.dtsi          |  79 +++++++++++++++
  arch/arm/boot/dts/s3c24xx.dtsi          |  92 +++++++++++++++++
  arch/arm/mach-s3c24xx/Kconfig           |  12 +++
  arch/arm/mach-s3c24xx/Makefile          |   1 +
  arch/arm/mach-s3c24xx/mach-s3c2416-dt.c |  91 +++++++++++++++++
  8 files changed, 521 insertions(+)
  create mode 100644 arch/arm/boot/dts/s3c2416-pinctrl.dtsi
  create mode 100644 arch/arm/boot/dts/s3c2416-smdk2416.dts
  create mode 100644 arch/arm/boot/dts/s3c2416.dtsi
  create mode 100644 arch/arm/boot/dts/s3c24xx.dtsi
  create mode 100644 arch/arm/mach-s3c24xx/mach-s3c2416-dt.c
