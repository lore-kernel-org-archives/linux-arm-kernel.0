From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 26 Feb 2016 15:25:45 +0100
Subject: [GIT PULL] ARM: mvebu: cleanup for v4.6 (#2)
Message-ID: <87fuwfo8eu.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second pull request for cleanup for mvebu for v4.6.

Gregory

The following changes since commit 727c62d29c3a0b982fb72ef993db95e9d2036e07:

  ARM: mv78xx0: use "depends on" instead of "if" after prompt (2016-01-25 16:43:16 +0100)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-cleanup-4.6-2

for you to fetch changes up to 7d8f9ac16223cf14f199a96355b0add4ca286662:

  ARM: mvebu: add missing of_node_put() (2016-02-08 17:30:14 +0100)

----------------------------------------------------------------
mvebu cleanup for 4.6 (part 2)

Add a missing call to of_node_put() armada_xp_smp_prepare_cpus()

----------------------------------------------------------------
Masahiro Yamada (1):
      ARM: mvebu: add missing of_node_put()

 arch/arm/mach-mvebu/platsmp.c | 1 +
 1 file changed, 1 insertion(+)
