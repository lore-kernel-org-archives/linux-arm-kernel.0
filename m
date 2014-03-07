From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 7 Mar 2014 12:10:27 -0500
Subject: [GIT PULL] ARM: mvebu: soc changes for v3.15 (incr. #3)
Message-ID: <20140307171027.GG18707@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

This should be the last pull request for mvebu/soc for v3.15.  It's a
small change and a big one all rolled into one :-P

With the dove pinctrl changes going through LinusW's tree, this patch is
all that's really necessary for the move.

As usual, this is an incremental pull request from tags/mvebu-soc-3.15-2
in the mvebu/soc branch up to tags/mvebu-soc-3.15-3.

Please pull.

thx,

Jason.

The following changes since commit 0d75ab68fd1a516f7a394fac6ba0f0ef34bbd18e:

  Merge branch 'mvebu/soc-kw' into mvebu/soc (2014-03-01 03:21:04 +0000)

are available in the git repository at:


  git://git.infradead.org/linux-mvebu.git tags/mvebu-soc-3.15-3

for you to fetch changes up to 00e8ec2f0b05bfc8acaf13cf91c2ca1e624f3535:

  ARM: mvebu: move DT Dove to MVEBU (2014-03-04 04:13:48 +0000)

----------------------------------------------------------------
mvebu soc changes for v3.15 (incremental #3)

 - dove
    - move devicetree code from mach-dove/ to mach-mvebu/ :-)

----------------------------------------------------------------
Sebastian Hesselbarth (1):
      ARM: mvebu: move DT Dove to MVEBU

 arch/arm/boot/dts/Makefile                           |  2 +-
 arch/arm/mach-dove/Kconfig                           | 12 ------------
 arch/arm/mach-dove/Makefile                          |  1 -
 arch/arm/mach-mvebu/Kconfig                          | 12 ++++++++++++
 arch/arm/mach-mvebu/Makefile                         |  1 +
 arch/arm/{mach-dove/board-dt.c => mach-mvebu/dove.c} | 20 ++++++++------------
 6 files changed, 22 insertions(+), 26 deletions(-)
 rename arch/arm/{mach-dove/board-dt.c => mach-mvebu/dove.c} (61%)
