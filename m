From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 12 Mar 2018 09:37:37 +0100
Subject: [GIT PULL 1/2] Rockchip dts32 fixes for 4.16
Message-ID: <22043255.iBjVuxpHK5@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof

please find below some more fixes for 4.16 .

I wasn't sure if dtc warning count as fixes, so feel free to ignore the
arm32 part, but the arm64 changes are somewhat important as they
fix usb and suspend regressions, so please pull


Thanks
Heiko


The following changes since commit e78c637127ee7683d606737f2e62b5da6fd7b1c3:

  ARM: dts: rockchip: Fix DWMMC clocks (2018-02-16 10:45:16 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.16-rockchip-dts32fixes-2

for you to fetch changes up to 4e943a890cef42e90f43ce6be64728a290b97c55:

  ARM: dts: rockchip: Add missing #sound-dai-cells on rk3288 (2018-03-05 15:18:58 +0100)

----------------------------------------------------------------
Fix for a new dtc warning.

----------------------------------------------------------------
Rob Herring (1):
      ARM: dts: rockchip: Add missing #sound-dai-cells on rk3288

 arch/arm/boot/dts/rk3288.dtsi | 2 ++
 1 file changed, 2 insertions(+)
