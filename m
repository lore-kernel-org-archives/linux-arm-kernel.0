From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Fri, 22 Dec 2017 11:21:05 +0100
Subject: [GIT PULL] arm: actions: dt for v4.16 #1
Message-ID: <20171222102107.5661-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof and Arnd,

Here's my dt pull for Actions Semi.
This adds one new S500 based board, which I already updated to new SPDX style.
A second pull will follow after I've converted the existing boards.

Regards,
Andreas

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git tags/actions-arm-dt-for-4.16

for you to fetch changes up to 271a70da383cf69f32742d9e2d01a7b16d04d60c:

  arm: dts: owl-s500: Add Sparky (2017-12-22 10:53:52 +0100)

----------------------------------------------------------------
Actions Semi arm based SoC DT for v4.16

This adds a DT for the Allo.com Sparky SBC.

----------------------------------------------------------------
Andreas F?rber (3):
      dt-bindings: Add vendor prefix for Allo.com
      dt-bindings: arm: actions: Add Sparky
      arm: dts: owl-s500: Add Sparky

 Documentation/devicetree/bindings/arm/actions.txt  |  1 +
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 arch/arm/boot/dts/Makefile                         |  3 +-
 arch/arm/boot/dts/owl-s500-sparky.dts              | 43 ++++++++++++++++++++++
 4 files changed, 47 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/owl-s500-sparky.dts
