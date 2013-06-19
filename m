From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 19 Jun 2013 11:52:29 +0200
Subject: [GIT PULL] Allwinner sunXi defconfig additions for 3.11
Message-ID: <20130619095229.GA7906@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here is a rather small pull request for a change in the
multi_v7_defconfig needed for the Allwinner SoCs.

The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

  git://github.com/mripard/linux.git tags/sunxi-defconfig-for-3.11

for you to fetch changes up to fb1c60288a886a28dc7c055449fd1936140fe891:

  ARM: multi_v7: Enable Allwinner EMAC in multi_v7_defconfig (2013-06-19 11:07:50 +0200)

----------------------------------------------------------------
Allwinner defconfig changes for 3.11

----------------------------------------------------------------
Maxime Ripard (1):
      ARM: multi_v7: Enable Allwinner EMAC in multi_v7_defconfig

 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
