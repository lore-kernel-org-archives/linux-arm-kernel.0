From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 20 Mar 2018 02:18:35 +0100
Subject: Fwd: [GIT PULL] DTS changes for RealView+Versatile
In-Reply-To: <CACRpkdYzBfAgUZUosJEyjfNoRdYSsVUKG_tu4bn7L6CgKmwoGA@mail.gmail.com>
References: <CACRpkdYzBfAgUZUosJEyjfNoRdYSsVUKG_tu4bn7L6CgKmwoGA@mail.gmail.com>
Message-ID: <CACRpkdafB1Tg6ZUtN6k26y_rpZ8RB4oNDjL+Obiu_soDccMsmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this augments the RealView and Versatile device trees for
DRM om PL111. It also adds a smallish device tree for the
Versatile with the IB2 daughterboard.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/armsoc-versatile-drm-dts

for you to fetch changes up to e65857a64f69077ca95c79028a2e7f3b580fe19e:

  ARM: dts: Augment panel setting for Versatile (2018-03-20 02:04:39 +0100)

----------------------------------------------------------------
This augments the RealView and Versatile device trees to properly
define the VGA and panel connectors in preparation for DRM.

----------------------------------------------------------------
Linus Walleij (6):
      ARM: dts: Augment VGA connector bridge on PB11MPcore
      ARM: dts: Augment VGA connector bridge on PB1176
      ARM: dts: Augment VGA connector bridge on Realview EB
      ARM: dts: Augment VGA connector bridge on Realview PBX
      ARM: dts: Add Versatile IB2 device tree
      ARM: dts: Augment panel setting for Versatile

 arch/arm/boot/dts/Makefile                |  1 +
 arch/arm/boot/dts/arm-realview-eb.dtsi    | 64 +++++++++++++++---------
 arch/arm/boot/dts/arm-realview-pb1176.dts | 66 ++++++++++++++----------
 arch/arm/boot/dts/arm-realview-pb11mp.dts | 78 +++++++++++++++++++----------
 arch/arm/boot/dts/arm-realview-pbx.dtsi   | 82 ++++++++++++++++++++----------
 arch/arm/boot/dts/versatile-ab-ib2.dts    | 26 ++++++++++
 arch/arm/boot/dts/versatile-ab.dts        | 83 ++++++++++++++++++++++++++++++-
 7 files changed, 296 insertions(+), 104 deletions(-)
 create mode 100644 arch/arm/boot/dts/versatile-ab-ib2.dts
