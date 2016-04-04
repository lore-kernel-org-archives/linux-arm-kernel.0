From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Apr 2016 10:22:20 +0900
Subject: [GIT PULL] Renesas ARM64 Based SoC DT Updates for v4.7
Message-ID: <cover.1459731817.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM64 based SoC DT updates for v4.7.


The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt-for-v4.7

for you to fetch changes up to 81ae0ac31bb90baef10850fdfdc2a9f72f36aa6f:

  arm64: dts: r8a7795: Use USB3.0 fallback compatibility string (2016-03-28 08:52:47 +0900)

----------------------------------------------------------------
Renesas ARM64 Based SoC DT Updates for v4.7

* Use USB3.0 fallback compatibility string in DT for r8a7795 SoC
* Add CAN support to DT for r8a7795 SoC

----------------------------------------------------------------
Ramesh Shanmugasundaram (2):
      arm64: dts: r8a7795: Add CAN external clock support
      arm64: dts: r8a7795: Add CAN support

Simon Horman (1):
      arm64: dts: r8a7795: Use USB3.0 fallback compatibility string

 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 42 ++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)
