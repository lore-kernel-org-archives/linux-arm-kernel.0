From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Apr 2016 10:22:07 +0900
Subject: [GIT PULL] Renesas ARM64 Based SoC Cleanup for v4.7
Message-ID: <cover.1459731706.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM64 based SoC cleanup for v4.7.


The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-cleanup-for-v4.7

for you to fetch changes up to fa3d2aede8bf9dd69e9309230169b5ec1cc234e4:

  arm64: dts: salvator-x: use generic pinctrl properties (2016-03-28 08:50:52 +0900)

----------------------------------------------------------------
Renesas ARM64 Based SoC Cleanup for v4.7

* Use generic pinctrl properties in DT for salvator-x board

----------------------------------------------------------------
Simon Horman (1):
      arm64: dts: salvator-x: use generic pinctrl properties

 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 46 +++++++++++-----------
 1 file changed, 23 insertions(+), 23 deletions(-)
