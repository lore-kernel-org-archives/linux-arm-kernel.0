From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Jul 2013 13:35:32 +0900
Subject: [GIT PULL 0/2] Renesas ARM based SoC fixes for v3.11
Message-ID: <cover.1372739438.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Hi Olof,

please consider the following fixes for v3.11, both of which are suitable for
stable.

This pull request is based on renesas-soc2-for-v3.11 which you have
already pulled.


The following changes since commit 018222f5d32bc5ca9fd830aebfeed10f1be96c93:

  ARM: shmobile: r8a7790: add clock definitions and aliases for MMCIF and SDHI (2013-06-12 21:07:38 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fixes-for-v3.11

for you to fetch changes up to 1eb14ea1e6bcd11d6d0ba937fc39808bb4d3453e:

  ARM: shmobile: emev2 GIO3 resource fix (2013-07-02 12:28:01 +0900)

----------------------------------------------------------------
Renesas ARM based SoC fixes for v3.11

* Correct GIO3 base addresses for EMEV2 SoC
  - This bug bug added when GPIO support was added for the EMEV2 SoC
    in v3.5

* Correct SCIFB0 resources for r8a77a4 SoC
  - This was a bug was added when SCIF support was added for the r8a77a4 SoC
    in v3.10

----------------------------------------------------------------
Magnus Damm (1):
      ARM: shmobile: emev2 GIO3 resource fix

Takanari Hayama (1):
      ARM: shmobile: r8a73a4: Fix resources for SCIFB0

 arch/arm/mach-shmobile/setup-emev2.c   | 8 ++++----
 arch/arm/mach-shmobile/setup-r8a73a4.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)
