From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 26 Jul 2018 10:20:39 +0200
Subject: [GIT PULL] ARM: mediatek: soc updates for v4.19
In-Reply-To: <9fdbdba4-c2e0-510d-62bb-e0a604942e19@gmail.com>
References: <9fdbdba4-c2e0-510d-62bb-e0a604942e19@gmail.com>
Message-ID: <97140b0d-ebc7-4fc2-e953-0709da22264b@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,
Hi Arnd,

This is the second attempt to send the pull request, as in the first one I sent
the branch instead of the tag.

Please have a look.
Regards,
Matthias

---

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/
tags/v4.18-next-soc

for you to fetch changes up to 00673189b8b971c00417632ffe4c90ba9b4f2568:

  soc: mediatek: pwrap: add mt6351 driver for mt6797 SoCs (2018-07-16 15:50:17
+0200)

----------------------------------------------------------------
- add pmic wrapper support for mt6797
- pmic wrapper fix chiper init
- add support for pmic mt6351

----------------------------------------------------------------
Argus Lin (4):
      dt-bindings: pwrap: mediatek: add pwrap support for MT6797
      soc: mediatek: pwrap: fix cipher init setting error
      soc: mediatek: pwrap: add pwrap driver for mt6797 SoCs
      soc: mediatek: pwrap: add mt6351 driver for mt6797 SoCs

 .../devicetree/bindings/soc/mediatek/pwrap.txt     |  1 +
 drivers/soc/mediatek/mtk-pmic-wrap.c               | 81 +++++++++++++++++++++-
 2 files changed, 80 insertions(+), 2 deletions(-)
