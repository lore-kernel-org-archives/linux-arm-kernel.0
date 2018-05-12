From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 12 May 2018 13:41:07 +0200
Subject: [GIT PULL] Gemini DTS updates for v4.18
Message-ID: <CACRpkdZ+GR2j01CMAnU=pYwZHPZ6j5hhEefF7HckUM4jq=n2MA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks!

This fixes a host of issues and adds some new stuff to the
Gemini platforms. We now have them all running (more or
less) with OpenWRT. Details in the patches and signed tag.

Please pull this to ARM SoC DTS updates for v4.18.

Yours,
Linus Walleij

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
tags/gemini-dts-arm-soc

for you to fetch changes up to e7c881596baf8d1a4a1b872c4670da6723246936:

  ARM: dts: Fix DTC warnings (2018-05-12 13:27:24 +0200)

----------------------------------------------------------------
DTS updates for the Gemini:
- Set righ flashes on DNS-313
- Activate ATA1 on NAS4220B
- Set right harddisk triggers on the D-Link devices
- Fix all DTC warnings

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ARM: dts: gemini: Fix "debounce-interval" property misspelling

Linus Walleij (6):
      ARM: dtd: Set DNS-313 LEDs to use better triggers
      ARM: dts: Set DNS-685 LEDs to use better triggers
      ARM: dts: Fix the DNS-313 flash compatible
      ARM: dts: Fix bootargs for Gemini D-Link devices
      ARM: dts: Add second ATA to NAS4220B
      ARM: dts: Fix DTC warnings

 arch/arm/boot/dts/gemini-dlink-dir-685.dts | 16 +++++++++-------
 arch/arm/boot/dts/gemini-dlink-dns-313.dts | 19 +++++++++++--------
 arch/arm/boot/dts/gemini-nas4220b.dts      | 20 +++++++++++---------
 arch/arm/boot/dts/gemini-rut1xx.dts        | 12 +++++-------
 arch/arm/boot/dts/gemini-sq201.dts         | 12 +++++-------
 arch/arm/boot/dts/gemini-wbd111.dts        | 17 ++++++++---------
 arch/arm/boot/dts/gemini-wbd222.dts        | 16 +++++++---------
 arch/arm/boot/dts/gemini.dtsi              |  2 --
 8 files changed, 56 insertions(+), 58 deletions(-)
