From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 15 Jul 2018 01:15:02 +0200
Subject: [GIT PULL] Gemini DTS updates for v4.19
Message-ID: <CACRpkdbGQ2Pzb4q32Pg_gOrpxWfuUzbB-wEdqwd0X766FBydNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

please pull these three DTS updates for v4.19!
Details in the signed tag.

Yours,
Linus Walleij

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
tags/gemini-dts-v4.19

for you to fetch changes up to 41043ec45bdea5970e7c2d6766caf0793aeeb159:

  ARM: dts: Add devicetree for Storlink/Storm SL93512R (2018-07-15
01:09:26 +0200)

----------------------------------------------------------------
Gemini DTS updates for v4.19:
- Add Vitesse switch chips
- Add a new DT for a reference design

----------------------------------------------------------------
Linus Walleij (3):
      ARM: dts: Add WAN ethernet port to the SQ201
      ARM: dts: Add Vitesse G5e switch to the Gemini SQ201
      ARM: dts: Add devicetree for Storlink/Storm SL93512R

 arch/arm/boot/dts/Makefile            |   1 +
 arch/arm/boot/dts/gemini-sl93512r.dts | 328 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/gemini-sq201.dts    | 159 ++++++++++++++++
 3 files changed, 488 insertions(+)
 create mode 100644 arch/arm/boot/dts/gemini-sl93512r.dts
