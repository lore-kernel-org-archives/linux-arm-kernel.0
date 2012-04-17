From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Tue, 17 Apr 2012 12:15:52 +0530
Subject: [PATCH V1 0/3] ARM: dt: tegra: add ALS and proximity sensor ISL29018
Message-ID: <1334645155-13799-1-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Series of patches to enable the ALS and proximity sensor ISL29018 for
tegra_ventana.
The changes done here:
- Add vendor prefix in document.
- Fix the vendor prefix in isl29018 driver.
- Add entry for isl29018 in tegra-ventana.dts file.

Laxman Dewangan (3):
  devicetree: Document Intersil Corporation vendor prefix
  staging: iio: light: of: Fix vendor prefix of isl29018
  ARM: dt: tegra_ventana: als and proximity sensor isl29018 support

 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 arch/arm/boot/dts/tegra-ventana.dts                |    6 ++++++
 drivers/staging/iio/light/isl29018.c               |    2 +-
 3 files changed, 8 insertions(+), 1 deletions(-)
