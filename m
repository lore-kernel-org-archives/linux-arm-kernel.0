From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Sep 2017 09:54:30 +0200
Subject: [GIT PULL] Renesas ARM Based SoC Fixes for v4.14
Message-ID: <cover.1506324907.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC fixes for v4.14.


The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fixes-for-v4.14

for you to fetch changes up to 829e4887b8676255778e162efc57e4a0f18f8bb3:

  arm64: dts: salvator-common: add 12V regulator to backlight (2017-09-21 10:03:51 +0200)

----------------------------------------------------------------
Renesas ARM Based SoC Fixes for v4.14

Add 12V regulator to backlight allowing the power supply
for the backlight to be found.

----------------------------------------------------------------
Ulrich Hecht (1):
      arm64: dts: salvator-common: add 12V regulator to backlight

 arch/arm64/boot/dts/renesas/salvator-common.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)
