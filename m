From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  3 Mar 2015 09:24:46 +0900
Subject: [GIT PULL v2] Renesas ARM Based SoC Updates for v4.1
Message-ID: <cover.1425341961.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC updates for v4.1.

This is a revised version of an earlier pull-request with some
patches dropped and other shuffled over to the soc-cleanups branch:
I'll send pull requests for those changes later.


The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-for-v4.1

for you to fetch changes up to 744cadba1ae6b80b413aea87835855dcccad86fd:

  ARM: shmobile: No R-Car Gen2 CMA reservation when HIGHMEM=n (2015-02-24 07:13:54 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Updates for v4.1

* Do not make CMA reservation for R-Car Gen2 when HIGHMEM=n

----------------------------------------------------------------
Magnus Damm (1):
      ARM: shmobile: No R-Car Gen2 CMA reservation when HIGHMEM=n

 arch/arm/mach-shmobile/setup-rcar-gen2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
