From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Mar 2014 14:05:14 +0900
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Clock Updates for
 v3.15
Message-ID: <cover.1394082270.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider this second round of Renesas ARM based SoC clock updates
for v3.15.

This pull request is based on the previous round of
such requests, tagged as renesas-clock-for-v3.15,
which I have already sent a pull-request for.


The following changes since commit df55f6685a04a259cf59cd3fde02212b294461cc:

  ARM: shmobile: Remove legacy r8a7790 DT clocks (2014-02-24 08:54:44 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-clock2-for-v3.15

for you to fetch changes up to 9ced1d47719b5f32e4231338dd362c136518ed08:

  ARM: shmobile: r8a7790: add sound SCU clock support (2014-02-24 10:03:02 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC Clock Updates for v3.15

r8a7790 (R-Car H2) SoC
- Add sound SCU clock support

r8a7791 (R-Car M2) SoC
- Remove legacy clock aliases for DT devices

----------------------------------------------------------------
Kuninori Morimoto (1):
      ARM: shmobile: r8a7790: add sound SCU clock support

Laurent Pinchart (1):
      ARM: shmobile: r8a7791: Remove legacy clock aliases for DT devices

 arch/arm/mach-shmobile/clock-r8a7790.c | 25 +++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-r8a7791.c |  1 -
 2 files changed, 25 insertions(+), 1 deletion(-)
