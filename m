From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 16 Dec 2017 20:37:44 +0100
Subject: [GIT PULL] Gemini DTS updates for v4.16 take one
Message-ID: <CACRpkdYDy202SZ5kOGU5vVsTAgH4kAAMWzaQ1O9jR3d9zGAPPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

I was hoping to send more DTS updates but the drivers are
waiting for review, so might as well get the DTS updates that
are finished upstream for linux-next.

Please pull this to some gemini DTS branch, I'll build more
patches on top of this if need be.

Yours,
Linus Walleij

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
tags/gemni-dts-1

for you to fetch changes up to dd5c0561db755845f0fd372c9bdb3099dce1a1c8:

  ARM: dts: Add basic devicetree for D-Link DNS-313 (2017-12-16 20:32:22 +0100)

----------------------------------------------------------------
Gemini DTS updates, take one

----------------------------------------------------------------
Linus Walleij (2):
      ARM: dts: Add ethernet PHYs to the a bunch of Geminis
      ARM: dts: Add basic devicetree for D-Link DNS-313

 arch/arm/boot/dts/Makefile                 |   1 +
 arch/arm/boot/dts/gemini-dlink-dns-313.dts | 241 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/gemini-nas4220b.dts      |  13 ++
 arch/arm/boot/dts/gemini-rut1xx.dts        |  13 ++
 arch/arm/boot/dts/gemini-wbd111.dts        |  13 ++
 arch/arm/boot/dts/gemini-wbd222.dts        |  18 +++
 6 files changed, 299 insertions(+)
 create mode 100644 arch/arm/boot/dts/gemini-dlink-dns-313.dts
