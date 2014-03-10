From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 10 Mar 2014 17:36:55 +0900
Subject: [GIT PULL] Third Round of Renesas ARM Based SoC Updates for v3.15
Message-ID: <cover.1394440471.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider this third round of Renesas ARM based SoC updates for v3.15.

I am sending this pull request after the release of v3.14-rc6
as it only includes a fix.

This pull request is based on the previous round of
such requests, tagged as renesas-soc2-for-v3.15,
which I have already sent a pull-request for.


The following changes since commit c4ca5d80e03559fd95c526ece5ce39fc732a2511:

  ARM: shmobile: Move SYSC base variable to inside ifdefs (2014-02-26 14:53:35 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc3-for-v3.15

for you to fetch changes up to 56ff873122c4baab43df241c7701d043b8ec8a8e:

  ARM: shmobile: APMU: Fix warnings due to improper printk formats (2014-03-06 13:14:03 +0900)

----------------------------------------------------------------
Third Round of Renesas ARM Based SoC Updates for v3.15

Fix warnings due to improper printk formats in shared APMU code.

----------------------------------------------------------------
Laurent Pinchart (1):
      ARM: shmobile: APMU: Fix warnings due to improper printk formats

 arch/arm/mach-shmobile/platsmp-apmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)
