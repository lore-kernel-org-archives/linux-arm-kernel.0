From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Sun, 20 Dec 2015 22:17:50 +0100
Subject: [GIT PULL] ARM: mediatek: arm64 updates for v4.4
Message-ID: <CABuKBeJGS0a5tLFbH=hJtsZ-Uma=7p+M67NuLtBpzhN7d--11A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Please pull the following patches.

Thanks,
Matthias

---

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  https://github.com/mbgg/linux-mediatek.git tags/v4.4-next-arm64

for you to fetch changes up to 05bdabe7ebc780e3cd9275f0f5795d337fa5acca:

  arm64: dts: mediatek: mt8173 PSCI-1.0 support (2015-11-20 13:42:29 +0100)

----------------------------------------------------------------
Update psci support to the arm,psci-1.0 to mt8173

Add display PWM driver to mt8173

Add mediatek general porpose timer to mt8173

----------------------------------------------------------------
Daniel Kurtz (1):
      arm64: dts: mt8173: add timer node

Fan Chen (1):
      arm64: dts: mediatek: mt8173 PSCI-1.0 support

YH Huang (1):
      arm64: dts: mt8173: add MT8173 display PWM driver support node

 arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 13 ++++++++++++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi    | 33 ++++++++++++++++++++++++++++-
 2 files changed, 45 insertions(+), 1 deletion(-)
