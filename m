From: carlo@caione.org (Carlo Caione)
Date: Mon, 2 Mar 2015 12:03:47 +0100
Subject: [GIT PULL] ARM: meson: SoC related changes
Message-ID: <CAOQ7t2bJ47sp=sqDqMzu3-ASyJHkfQGV=A4x1YMQn6YhzQkKVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Hi Olof,
In this pull request there is a small modification to Kconfig to
enable the Meson pinctrl driver and a couple of small documentation
patches that weren't merged.

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  https://github.com/carlocaione/linux-meson tags/for-v4.0-rc/meson-soc

for you to fetch changes up to 3cada3a4daeee52499751f0bf350b6b0655c32ef:

  of: Define board compatible for MINIX NEO-X8 (2015-03-02 11:00:02 +0100)

----------------------------------------------------------------
- Add some forgotten documentation
- Kconfig changes to enable PINCTRL

----------------------------------------------------------------
Beniamino Galvani (3):
      ARM: meson: select PINCTRL_MESON and ARCH_REQUIRE_GPIOLIB
      of: Add vendor prefix for MINIX
      of: Define board compatible for MINIX NEO-X8

 Documentation/devicetree/bindings/arm/amlogic.txt     | 4 ++++
 Documentation/devicetree/bindings/arm/geniatech.txt   | 5 -----
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 arch/arm/mach-meson/Kconfig                           | 3 +++
 4 files changed, 8 insertions(+), 5 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/geniatech.txt
