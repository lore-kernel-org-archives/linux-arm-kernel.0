From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:14:48 +0200
Subject: [GIT PULL] Renesas ARM64 Based SoC Defconfig Updates for v4.18
Message-ID: <cover.1526548323.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM64 based SoC defconfig updates for v4.18.


The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-defconfig-for-v4.18

for you to fetch changes up to c1fcd2ec1b1970e0e7b0c40c64bc51cf667b1a75:

  arm64: defconfig: enable R8A77990 SoC (2018-05-16 11:08:20 +0200)

----------------------------------------------------------------
Renesas ARM64 Based SoC Defconfig Updates for v4.18

* Enable in ARM64 defconfig:
  - Recently mainlined support for R-Car E3 (r8a77990) SoC

  - HDMI sound and depdencies.

    HDMI sound is used by R-Car Gen 3.  These options are enabled as
    modules to avoid unnecesesarily enlarging the kernel image.

----------------------------------------------------------------
Kuninori Morimoto (2):
      arm64: defconfig: makes SND_SIMPLE_CARD to module
      arm64: defconfig: Enable CONFIG_SND_AUDIO_GRAPH_CARD

Simon Horman (1):
      arm64: defconfig: enable R8A77990 SoC

 arch/arm64/configs/defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
