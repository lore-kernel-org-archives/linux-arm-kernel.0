From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  2 Nov 2016 10:23:53 +0100
Subject: [GIT PULL] Renesas ARM Based SoC Defconfig Updates for v4.10
Message-ID: <cover.1478078446.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC defconfig updates for v4.10.


The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig-for-v4.10

for you to fetch changes up to a604a37d46b80899d5a09d937fdd670e93af690d:

  ARM: shmobile: defconfig: Enable CONFIG_CGROUPS (2016-10-17 08:24:41 +0200)

----------------------------------------------------------------
Renesas ARM Based SoC Defconfig Updates for v4.10

* Enable cgroups in shmobile_defconfig

----------------------------------------------------------------
Niklas S?derlund (1):
      ARM: shmobile: defconfig: Enable CONFIG_CGROUPS

 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)
