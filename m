From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 14 Nov 2014 16:57:19 +0100
Subject: [GIT PULL] ARM: mediatek: SoC updates for 3.19
Message-ID: <CABuKBe+6hvfKGXSp1uRrbVwUoiCdwEGD1Lin951B6jUgr4_rQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Here comes the pull request which add earlyprintk support for mt8127 and mt8135.
Apart from that the Kconfig entry for the Mediatek architecture was fixed.

Cheers,
Matthias

---

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  https://github.com/mbgg/linux-mediatek.git tags/v3.19-next-soc

for you to fetch changes up to af49f5a2a1902c40d734a9c43f67d2fb434fcb91:

  ARM: mediatek: Fix description for mediatek SoCs (2014-11-14 13:44:57 +0100)

----------------------------------------------------------------
Add earlyprintk to mt8127 and mt8135 and update Kconfig entry for Mediatek SoCs.

----------------------------------------------------------------
Joe.C (2):
      ARM: mediatek: Add earlyprintk support for mt8127 & mt8135
      ARM: mediatek: Fix description for mediatek SoCs

 arch/arm/Kconfig.debug         | 20 ++++++++++++++++++++
 arch/arm/mach-mediatek/Kconfig |  4 ++--
 2 files changed, 22 insertions(+), 2 deletions(-)
