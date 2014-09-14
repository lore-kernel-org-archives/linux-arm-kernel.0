From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 14 Sep 2014 04:41:02 -0400
Subject: [GIT PULL] ARM: mvebu: SoC changes for v3.18
Message-ID: <20140914084102.GW21986@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

This is a small one.  Things sure have been quiet this time around...

Please pull.

thx,

Jason.


The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-soc-3.18

for you to fetch changes up to 9d06d34bcc62f4cc3679704ac42cff5b44a97c6e:

  ARM: orion5x: Convert pr_warning to pr_warn (2014-09-13 21:29:21 +0000)

----------------------------------------------------------------
mvebu SoC changes for v3.18

 - orion5x
    - remove pr_warning(), use pr_warn()

----------------------------------------------------------------
Joe Perches (1):
      ARM: orion5x: Convert pr_warning to pr_warn

 arch/arm/mach-orion5x/dns323-setup.c           | 8 ++++----
 arch/arm/mach-orion5x/terastation_pro2-setup.c | 2 +-
 arch/arm/mach-orion5x/ts209-setup.c            | 2 +-
 arch/arm/mach-orion5x/ts409-setup.c            | 2 +-
 arch/arm/mach-orion5x/ts78xx-setup.c           | 4 ++--
 5 files changed, 9 insertions(+), 9 deletions(-)
