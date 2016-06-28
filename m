From: xuwei5@hisilicon.com (Wei Xu)
Date: Tue, 28 Jun 2016 18:46:24 +0100
Subject: [GIT PULL] ARM: hisi: DT changes for v4.8
Message-ID: <5772B7F0.6040600@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Hi Olof, Hi Kevin,

Please help to pull the following changes.
Thanks!

Best Regards,
Wei

---

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://github.com/hisilicon/linux-hisi.git tags/hisi-armv7-soc-dt-for-4.8

for you to fetch changes up to 04f66aa916c141113266646942d449b5781550e3:

  ARM: dts: add dts files for Hi3519 and tidy up the makefile entries (2016-06-28 17:27:53 +0100)

----------------------------------------------------------------
ARM: DT: Hisilicon ARMv7 SoC Hi3519 DT updates for 4.8

- Add device tree bindings for hi3519 sysctrl
- Add dts files for hi3519
- Tidy up DTB makefile entries to keep the list sorted

----------------------------------------------------------------
Jiancheng Xue (2):
      ARM: dt-bindings: add device tree bindings for Hi3519 sysctrl
      ARM: dts: add dts files for Hi3519 and tidy up the makefile entries

 Documentation/devicetree/bindings/arm/hisilicon/hi3519-sysctrl.txt |  14 ++++++++++
 arch/arm/boot/dts/Makefile |   6 +++--
 arch/arm/boot/dts/hi3519-demb.dts |  42 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/hi3519.dtsi | 187 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 247 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hi3519-sysctrl.txt
 create mode 100644 arch/arm/boot/dts/hi3519-demb.dts
 create mode 100644 arch/arm/boot/dts/hi3519.dtsi
