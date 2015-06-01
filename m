From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 1 Jun 2015 12:30:24 +0200
Subject: [GIT PULL] ARM: mediatek: arm64 updates for v4.2
Message-ID: <CABuKBeL1mq_Q3fxQtWeSGV-vHWqiVr1wTVKzj_KA1c27oKxMcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Please pull the following updates for v4.2.

Thanks,
Matthias

---

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  https://github.com/mbgg/linux-mediatek.git tags/v4.1-next-arm64

for you to fetch changes up to e881ad1bc6e46fc933fef77cfe587625e30478e9:

  arm64: dts: mt8173: fix some indentation (2015-06-01 10:06:12 +0200)

----------------------------------------------------------------
- dts: mt8173: fix style convention for pinctrl node
- dts: mt8173: fix indentation for some nodes

----------------------------------------------------------------
Daniel Kurtz (1):
      arm64: dts: mt8173: fix some indentation

Yingjoe Chen (1):
      arm64: dts: mt8173: Fixup pinctrl nodes

 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 41 +++++++++++++++++---------------
 1 file changed, 22 insertions(+), 19 deletions(-)
