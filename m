From: carlo@caione.org (Carlo Caione)
Date: Mon, 4 Jan 2016 11:18:16 +0100
Subject: [GIT PULL] Amlogic DT changes for 4.5
Message-ID: <CAOQ7t2ZrdOVedX4OcxKYAayaDWSFsZNuv988oED7oDRnu70Wiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
just a few patches for the Meson8b SoC. Wim has already added the new
watchdog driver to linux-watchdog-next.

Thanks
---

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  https://github.com/carlocaione/linux-meson tags/meson-for-4.5/dts

for you to fetch changes up to e9c478a93c113e0ee47f40b80962abe2e2feccc0:

  ARM: dts: meson8b: Add watchdog node (2016-01-04 10:54:45 +0100)

----------------------------------------------------------------
This pull request includes the Amlogic Meson8b DTS changes for v4.5

----------------------------------------------------------------
Carlo Caione (2):
      Documentation: watchdog: Add new bindings for meson8b
      ARM: dts: meson8b: Add watchdog node

Edward Cragg (1):
      ARM: meson: Add status LED for Odroid-C1

 Documentation/devicetree/bindings/watchdog/{meson6-wdt.txt =>
meson-wdt.txt} |  2 +-
 arch/arm/boot/dts/meson8b-odroidc1.dts
       | 11 +++++++++++
 arch/arm/boot/dts/meson8b.dtsi
       |  6 ++++++
 3 files changed, 18 insertions(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/watchdog/{meson6-wdt.txt =>
meson-wdt.txt} (75%)
