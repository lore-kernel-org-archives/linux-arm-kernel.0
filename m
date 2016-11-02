From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  2 Nov 2016 10:23:40 +0100
Subject: [GIT PULL] Renesas ARM64 Based SoC Defconfig Updates for v4.10
Message-ID: <cover.1478078567.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM64 based SoC defconfig updates for v4.10.


The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-defconfig-for-v4.10

for you to fetch changes up to 833c97254724a620d1d9fb9a580681fb52536fbf:

  arm64: defconfig: Enable DRM DU and V4L2 FCP + VSP modules (2016-10-27 09:07:35 +0200)

----------------------------------------------------------------
Renesas ARM64 Based SoC Defconfig Updates for v4.10

* Enable R-Car DU and related drivers as modules in defconfig

----------------------------------------------------------------
Magnus Damm (1):
      arm64: defconfig: Enable DRM DU and V4L2 FCP + VSP modules

 arch/arm64/configs/defconfig | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
