From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 20 May 2013 16:00:29 -0400
Subject: [GIT PULL] ARM: mvebu: soc changes for v3.11 (round 1)
Message-ID: <20130520200029.GJ31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/soc-3.11-1

for you to fetch changes up to 3207792e62498f872d64f12e2fc368aa9d7e3795:

  arm: kirkwood: use the default of match table (2013-05-19 20:20:49 +0000)

----------------------------------------------------------------
mvebu soc changes for v3.11 (round 1)

 - kirkwood: use default of match table

----------------------------------------------------------------
Thomas Petazzoni (1):
      arm: kirkwood: use the default of match table

 arch/arm/mach-kirkwood/board-dt.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)
