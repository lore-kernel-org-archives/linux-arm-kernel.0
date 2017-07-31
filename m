From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 31 Jul 2017 17:02:28 +0200
Subject: [GIT PULL] Renesas ARM64 Based SoC Defconfig Updates for v4.14
Message-ID: <cover.1501509815.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM64 based SoC defconfig updates for v4.14.


The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-defconfig-for-v4.14

for you to fetch changes up to 140cb4111a51381f51f6cdcc97113f2d04e5939b:

  arm64: defconfig: compile ak4613 and renesas sound as modules (2017-07-27 15:51:58 +0200)

----------------------------------------------------------------
Renesas ARM64 Based SoC Defconfig Updates for v4.14

* compile ak4613 and renesas sound as modules

  This is intended to reduce the size of a kernel image compiled
  using the defconfig. This is timely as it brings the kernel image
  back below the size that can be booted in my environment, a limit
  it crept over in v4.13-rc1.

----------------------------------------------------------------
Kuninori Morimoto (1):
      arm64: defconfig: compile ak4613 and renesas sound as modules

 arch/arm64/configs/defconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
