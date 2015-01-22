From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 22 Jan 2015 14:19:08 +0100
Subject: [GIT PULL] ARM: mediatek: soc changes for v3.20 (round 1)
Message-ID: <CABuKBe+_Xp7LWExkM6xygM_adtKTVuG3S9zMdc27TonWu0HKNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Please take the following patches for v3.20.

Thanks a lot,
Matthias

---

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  https://github.com/mbgg/linux-mediatek.git tags/v3.20-next-soc1

for you to fetch changes up to 60851d7a81138ba3546dde044a8d629c1f603525:

  ARM: mediatek: Low-level-debug for mt6592 (2015-01-20 17:50:26 +0100)

----------------------------------------------------------------
This adds config options for the different Mediatek SoC. We need this so that
the pinctrl driver does not bloat the kernel binary.

Apart we change the Kconfig description and add the config option for mt6592
low-level debug option.

----------------------------------------------------------------
Matthias Brugger (1):
      ARM: mediatek: Low-level-debug for mt6592

Yingjoe Chen (1):
      ARM: mediatek: Add config options for mediatek SoCs.

 arch/arm/Kconfig.debug         |  2 +-
 arch/arm/mach-mediatek/Kconfig | 22 +++++++++++++++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

-- 
motzblog.wordpress.com
