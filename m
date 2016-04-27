From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 28 Apr 2016 09:06:57 +1000
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Fixes for v4.6
Message-ID: <cover.1461798058.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC fixes for v4.6.

This fix allows serial to work on r8a7795-based boards where the optional
scif clock is not populated.

This pull request is based on the previous round of
such requests, tagged as renesas-fixes-for-v4.6,
which I have already sent a pull-request for.


The following changes since commit c531fb27e9699eaee478ee5686a3cca5dee73602:

  ARM: shmobile: timer: Fix preset_lpj leading to too short delays (2016-04-20 08:52:55 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fixes2-for-v4.6

for you to fetch changes up to f5515f9cdff136dc32517d4b81fe2b9091237b4a:

  arm64: dts: r8a7795: Don't disable referenced optional scif clock (2016-04-26 09:44:48 +1000)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC Fixes for v4.6

* Don't disable referenced optional scif clock

----------------------------------------------------------------
Geert Uytterhoeven (1):
      arm64: dts: r8a7795: Don't disable referenced optional scif clock

 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 1 -
 1 file changed, 1 deletion(-)
