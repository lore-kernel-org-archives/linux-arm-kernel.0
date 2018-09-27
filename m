From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 27 Sep 2018 09:33:40 +0200
Subject: [GIT PULL] DTS patch for RealView
Message-ID: <CACRpkdbuLQakD9vmX-CjGce4h7KtP8s2a8zVMCKmvGSWCDK7ew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

here is a realview patch.

Please pull it in! Description in the
signed tag.

Yours,
Linus Walleij

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/realview-dts-v4.20

for you to fetch changes up to 016add12977bcc30f77d7e48fc9a3a024cb46645:

  ARM: dts: realview: Fix SPI controller node names (2018-09-27 09:29:12 +0200)

----------------------------------------------------------------
Realview DTS update for v4.20:
- One patch from Rob fixing SPI node names

----------------------------------------------------------------
Rob Herring (1):
      ARM: dts: realview: Fix SPI controller node names

 arch/arm/boot/dts/arm-realview-eb.dtsi    | 2 +-
 arch/arm/boot/dts/arm-realview-pb1176.dts | 2 +-
 arch/arm/boot/dts/arm-realview-pb11mp.dts | 2 +-
 arch/arm/boot/dts/arm-realview-pbx.dtsi   | 2 +-
 arch/arm/boot/dts/versatile-ab.dts        | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)
