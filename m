From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 21 Dec 2015 02:28:27 +0100
Subject: [GIT PULL 3/3] rockchip dts64 changes for 4.5, round 2
In-Reply-To: <2532363.CsR3D6sdor@diego>
References: <2532363.CsR3D6sdor@diego>
Message-ID: <2617670.etrCQQMQaV@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

and finally a small stack of 64bit devicetree changes, mainly adding the
broadcast-timer node for the driver that got improved to support arm64
compilations.

So if these 3 look ok, please pull.


Thanks
Heiko


The following changes since commit 5378e28c9776fbab6065cfb54417acff3ea5f1fd:

  arm64: dts: rockchip: add rk3368 evaluation board (2015-12-02 00:35:22 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.5-rockchip-dts64-2

for you to fetch changes up to b8084e5b34e83875846053bf9cd951b7640e40fe:

  arm64: dts: rockchip: Add the broadcast-timer for RK3368 SoC (2015-12-12 23:20:38 +0100)

----------------------------------------------------------------
New node for the broadcast-timer of the rk3368, a non-critical fix for
a regulator voltage and a typo fix.

----------------------------------------------------------------
Caesar Wang (2):
      arm64: dts: rockchip: correct voltage range for rk3368-evb-act8846 board
      arm64: dts: rockchip: Add the broadcast-timer for RK3368 SoC

Matthias Brugger (1):
      arm64: dts: rockchip: Fix typo in rk3368 sdmmc card detect pin name

 arch/arm64/boot/dts/rockchip/rk3368-evb-act8846.dts | 6 +++---
 arch/arm64/boot/dts/rockchip/rk3368.dtsi            | 8 +++++++-
 2 files changed, 10 insertions(+), 4 deletions(-)
