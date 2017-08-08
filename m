From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 8 Aug 2017 14:25:28 +0200
Subject: [GIT PULL] Gemini DTS updates for v4.14 take one
Message-ID: <CACRpkdZYn1OXayC8ZdPeGJZ_ShQ5drRqVv5WBj3mdevqsHbCcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC guys,

this is the first set of DTS patches for Gemini for v4.14.

- Moves to using macros (patch submitted to be applied on
  top of v4.13-rc1 but it was missed, whatever)

- New DTS for the D-Link DIR-685

- Modify all device trees to include proper pin control.

This is infrastructure for any future extensions of the platform
so it is all nice to have in place.

Please pull it in on some appropriate branch!

Yours,
Linus Walleij

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
tags/gemini-dts-1

for you to fetch changes up to f328c2eac5d729a3654d2cef469b9e4acc338c4e:

  ARM: dts: gemini: add pin control set-up for the SoC (2017-08-08
14:20:00 +0200)

----------------------------------------------------------------
Gemini DTS updates for ARM SoC take one.

----------------------------------------------------------------
Linus Walleij (3):
      ARM: dts: gemini: Switch to using macros
      ARM: dts: Add DTS file for D-Link DIR-685
      ARM: dts: gemini: add pin control set-up for the SoC

 arch/arm/boot/dts/Makefile                 |   1 +
 arch/arm/boot/dts/gemini-dlink-dir-685.dts | 246 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/gemini-nas4220b.dts      |  24 +++
 arch/arm/boot/dts/gemini-rut1xx.dts        |  39 +++++
 arch/arm/boot/dts/gemini-sq201.dts         |  36 ++++-
 arch/arm/boot/dts/gemini-wbd111.dts        |  26 +++
 arch/arm/boot/dts/gemini-wbd222.dts        |  26 +++
 arch/arm/boot/dts/gemini.dtsi              | 173 ++++++++++++++++----
 8 files changed, 543 insertions(+), 28 deletions(-)
 create mode 100644 arch/arm/boot/dts/gemini-dlink-dir-685.dts
