From: tony@atomide.com (Tony Lindgren)
Date: Tue,  2 Jun 2015 10:22:16 -0700
Subject: [GIT PULL 2/3] omap defconfig changes for v4.2
In-Reply-To: <pull-1433265658-688305>
References: <pull-1433265658-688305>
Message-ID: <pull-1433265658-688305-2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.2/o2_dc

for you to fetch changes up to 4cbb08336f506cde30c0dfb3e49c55a52842fb5c:

  ARM: omap2plus_defconfig: Enable TOUCHSCREEN_PIXCIR (2015-06-02 07:54:50 -0700)

----------------------------------------------------------------
Few omap2plus_defconfig changes for v4.2 merge window:

- Enable dm9000 as built-in for NFSroot

- Enable dm816x USB phy as a loadable module

- Enable Pixcir touch screen as a loadable module

----------------------------------------------------------------
Anthoine Bourgeois (1):
      ARM: omap2plus_defconifg: Enable DM9000 in omap2plus_defconfig

Roger Quadros (1):
      ARM: omap2plus_defconfig: Enable TOUCHSCREEN_PIXCIR

Tony Lindgren (1):
      ARM: omap2plus_defconfig: Add dm816x USB PHY as a loadable module

 arch/arm/configs/omap2plus_defconfig | 3 +++
 1 file changed, 3 insertions(+)
