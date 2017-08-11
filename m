From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 11 Aug 2017 12:20:10 +0200
Subject: [GIT PULL] ARM: mvebu: soc for v4.14 (#1)
Message-ID: <8760duiexx.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for soc for mvebu for v4.14.

Gregory

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-soc-4.14-1

for you to fetch changes up to ca0a05a98f3090a77b678eaa778a30febc5795b8:

  ARM: mvebu: enable ARM_GLOBAL_TIMER compilation Armada 38x platforms (2017-08-03 15:17:06 +0200)

----------------------------------------------------------------
mvebu soc for 4.14 (part 1)

Enabling ARM_GLOBAL_TIMER in mvebu_v7_defconfig for Armada 38x

----------------------------------------------------------------
Marcin Wojtas (1):
      ARM: mvebu: enable ARM_GLOBAL_TIMER compilation Armada 38x platforms

 arch/arm/mach-mvebu/Kconfig | 2 ++
 1 file changed, 2 insertions(+)
