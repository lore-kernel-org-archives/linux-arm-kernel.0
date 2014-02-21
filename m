From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 21 Feb 2014 15:13:09 +0900
Subject: [GIT PULL] Third Round of Renesas ARM Based SoC Updates for v3.15
Message-ID: <cover.1392961497.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider this third round of Renesas ARM based SoC updates for v3.15.

This pull request is based on the previous round of
such requests, tagged as renesas-soc2-for-v3.15,
which I have already sent a pull-request for.


The following changes since commit 74b9ba5f35fbd071f313781498a9e244bcc6f03e:

  ARM: shmobile: r8a7790: Correct SYS DMAC clock defines (2014-02-07 09:24:07 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc3-for-v3.15

for you to fetch changes up to db47204b32dd0d72454b4f841d0f7e33c44ee2b8:

  ARM: shmobile: Remove __init from rcar_gen2_read_mode_pins() (2014-02-18 13:25:09 +0900)

----------------------------------------------------------------
Third Round of Renesas ARM Based SoC Updates for v3.15

* R-Car Gen2 SoCs: r8a7791 (R-Car M2) and r8a7790 (R-Car H2)
  - Remove __init from rcar_gen2_read_mode_pins()

* r8a7791 SoC (R-Car M2)
  - Add r8a7791 legacy SDHI clocks

* r8a7790 SoC (R-Car M2)
  - Remove legacy DT clocks

----------------------------------------------------------------
Magnus Damm (3):
      ARM: shmobile: Add r8a7791 legacy SDHI clocks
      ARM: shmobile: Remove legacy r8a7790 DT clocks
      ARM: shmobile: Remove __init from rcar_gen2_read_mode_pins()

 arch/arm/mach-shmobile/clock-r8a7790.c   | 11 -------
 arch/arm/mach-shmobile/clock-r8a7791.c   | 51 ++++++++++++++++++++++++++++++--
 arch/arm/mach-shmobile/setup-rcar-gen2.c |  2 +-
 3 files changed, 50 insertions(+), 14 deletions(-)
