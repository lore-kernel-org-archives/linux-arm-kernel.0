From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 11 Apr 2016 10:52:48 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Fixes for v4.6
Message-ID: <cover.1460339328.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC fixes for v4.6.


Allow serial to work once again on the Porter board (Revision B) which
does not have the oscillator in question mounted.


The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fixes-for-v4.6

for you to fetch changes up to e885767418bff0c591cc1e45babdd25d91b4a795:

  Revert "ARM: dts: porter: Enable SCIF_CLK frequency and pins" (2016-04-08 15:56:28 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Fixes for v4.6

* Revert "ARM: dts: porter: Enable SCIF_CLK frequency and pins"

----------------------------------------------------------------
Sjoerd Simons (1):
      Revert "ARM: dts: porter: Enable SCIF_CLK frequency and pins"

 arch/arm/boot/dts/r8a7791-porter.dts | 13 -------------
 1 file changed, 13 deletions(-)
