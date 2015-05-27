From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 27 May 2015 17:14:08 +0200
Subject: [GIT PULL] ARM: mediatek: arm64 updates for v4.2
Message-ID: <CABuKBeLhFR=94cF301wL7J8hJVTtyseoD7g45PLE6znQkPAFGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Please take the following changes into account.

Thanks,
Matthias

---

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  https://github.com/mbgg/linux-mediatek.git tags/v4.1-next-arm64

for you to fetch changes up to d211193d4ddeab0327f4b571ec34f641ae59eb89:

  arm64: dts: mt8173: Add PMIC wrapper device node (2015-05-27 13:41:18 +0200)

----------------------------------------------------------------
- dts: fixup pinctrl mt8173
- dts: mt8173-evb fix model name
- dts: mt8173 fix identation
- dts: mt8173 add clock controller
- dts: mt8173 change uart clocks
- dts: mt8173 add pmic wrapper

----------------------------------------------------------------
Daniel Kurtz (1):
      arm64: dts: mt8173: fix some indentation

Sascha Hauer (3):
      arm64: dts: mt8173: Add clock controller device nodes
      arm64: dts: mt8173: Use real clock for UARTs
      arm64: dts: mt8173: Add PMIC wrapper device node

Yingjoe Chen (2):
      arm64: dts: mt8173: Fixup pinctrl nodes
      arm64: dts: mt8173-evb: fix model name

 arch/arm64/boot/dts/mediatek/mt8173-evb.dts |  3 +-
 arch/arm64/boot/dts/mediatek/mt8173.dtsi    | 98 ++++++++++++++++++++++-------
 2 files changed, 78 insertions(+), 23 deletions(-)
