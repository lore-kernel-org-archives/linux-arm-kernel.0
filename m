From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Jul 2018 14:03:18 +0200
Subject: [GIT PULL] Renesas ARM64 Based SoC Defconfig Updates for v4.19
Message-ID: <cover.1532080241.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM64 based SoC defconfig updates for v4.19.


The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-defconfig-for-v4.19

for you to fetch changes up to 83c05e98f732bfa77830631e8d4403c76cad9b31:

  arm64: defconfig: Enable BD9571MWV regulator (2018-06-18 12:01:14 +0200)

----------------------------------------------------------------
Renesas ARM64 Based SoC Defconfig Updates for v4.19

* Enable BD9571MWV regulator in ARM64 defconfig

  This is to allow wider testing of the BD9571 PMIC which is
  present on boards with Renesas R-Car Gen3 SoCs

----------------------------------------------------------------
Dien Pham (1):
      arm64: defconfig: Enable BD9571MWV regulator

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)
