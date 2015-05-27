From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 27 May 2015 17:11:10 +0200
Subject: [GIT PULL] ARM: mediatek: dts updates for v4.2
Message-ID: <CABuKBeLETR3n2nExzd=BC_DvED_hehRd_04TvFbKPDQK+6rWGg@mail.gmail.com>
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

  https://github.com/mbgg/linux-mediatek.git tags/v4.1-next-dts

for you to fetch changes up to 7d580545387b20735d31b7307aa39483526a19cd:

  ARM: dts: mt8127: correct uart instance address (2015-05-16 10:21:15 +0200)

----------------------------------------------------------------
- dts: add pinctrl/GPIO/EINT to mt8135
- dts: fix uart address for mt8127

----------------------------------------------------------------
Hongzhou Yang (1):
      ARM: dts: mt8135: Add pinctrl/GPIO/EINT node for mt8135.

Yingjoe Chen (1):
      ARM: dts: mt8127: correct uart instance address

 arch/arm/boot/dts/mt8127.dtsi      |    8 +-
 arch/arm/boot/dts/mt8135-pinfunc.h | 1302 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/mt8135.dtsi      |   29 +
 3 files changed, 1335 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/boot/dts/mt8135-pinfunc.h
