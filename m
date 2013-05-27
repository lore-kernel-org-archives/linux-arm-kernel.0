From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 27 May 2013 18:00:04 +0900
Subject: [GIT PULL] Renesas ARM based r8a7779 SoC updates for v3.11
Message-ID: <1369645206-3682-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Hi Olof,

The following changes since commit c7788792a5e7b0d5d7f96d0766b4cb6112d47d75:

  Linux 3.10-rc2 (2013-05-20 14:37:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-r8a7779-for-v3.11

for you to fetch changes up to b2616eaa65e3ef188ececacdacbd42ce8a778ed9:

  ARM: shmobile: r8A7779: fix Ether device name (2013-05-22 22:17:33 +0900)

----------------------------------------------------------------
Renesas ARM based r8a7740 SoC updates for v3.11

* Correct Ether device's platform device name. By Sergei Shtylyov.
* Add PCIe clocks. By Phil Edworthy.

----------------------------------------------------------------
Phil Edworthy (1):
      ARM: shmobile: r8a7779: Add PCIe clocks

Sergei Shtylyov (1):
      ARM: shmobile: r8A7779: fix Ether device name

 arch/arm/mach-shmobile/clock-r8a7779.c |    4 +++-
 arch/arm/mach-shmobile/setup-r8a7779.c |    2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)
