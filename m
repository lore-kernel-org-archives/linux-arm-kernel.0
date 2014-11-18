From: carlo@caione.org (Carlo Caione)
Date: Tue, 18 Nov 2014 21:55:31 +0100
Subject: [GIT PULL] ARM: meson: SoC related changes
Message-ID: <20141118205531.GB19814@nuc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,
this is the pull request for the SoC related changes for the 3.19.
The support for Meson8 is added together with L2 cache management.


The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  https://github.com/carlocaione/linux-meson tags/v3.19-meson-soc

for you to fetch changes up to 7b6b0a455d98c7a314278e0fdca25ec6395a502a:

  clocksource: meson6: Select CLKSRC_MMIO (2014-11-18 16:41:20 +0100)

----------------------------------------------------------------
- Add Meson8 support
- Documentation for new compatible
- L2 cache management

----------------------------------------------------------------
Beniamino Galvani (4):
      ARM: meson: add meson8 support
      ARM: meson: document meson8 compatible properties
      ARM: meson: enable L2 cache
      clocksource: meson6: Select CLKSRC_MMIO

 Documentation/devicetree/bindings/arm/amlogic.txt |  8 +++++---
 arch/arm/mach-meson/Kconfig                       |  6 ++++++
 arch/arm/mach-meson/meson.c                       | 10 ++++++----
 drivers/clocksource/Kconfig                       |  1 +
 4 files changed, 18 insertions(+), 7 deletions(-)
