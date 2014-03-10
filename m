From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 10 Mar 2014 17:36:43 +0900
Subject: [GIT PULL] Third Round of Renesas ARM Based SoC Clock Updates for
 v3.15
Message-ID: <cover.1394440226.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider this third round of Renesas ARM based SoC clock updates
for v3.15.

I am posting this series after the release of v3.14-rc6 as it only
contains a fix.

This pull request is based on the previous round of
such requests, tagged as renesas-clock2-for-v3.15,
which I have already sent a pull-request for.


The following changes since commit 9ced1d47719b5f32e4231338dd362c136518ed08:

  ARM: shmobile: r8a7790: add sound SCU clock support (2014-02-24 10:03:02 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-clock3-for-v3.15

for you to fetch changes up to d93023f81d2c79595e64e4f516f03af4e4c73c13:

  ARM: shmobile: r7s72100: fix bus clock calculation (2014-03-06 13:22:02 +0900)

----------------------------------------------------------------
Third Round of Renesas ARM Based SoC Clock Updates for v3.15

r7s72100 (RZ/A1H) SoC
* Correct bus clock calculation

----------------------------------------------------------------
Wolfram Sang (1):
      ARM: shmobile: r7s72100: fix bus clock calculation

 arch/arm/mach-shmobile/clock-r7s72100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
