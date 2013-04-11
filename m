From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 11 Apr 2013 17:14:59 +0900
Subject: [GIT PULL] Renesas ARM based r8a7790 SoC update for v3.10
Message-ID: <1365668101-21723-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Hi Olof,

The following changes since commit 8585deb18580d04209a2986430aa0959ef38fce2:

  ARM: shmobile: r8a7790 SoC 64-bit DT support (2013-04-02 11:02:21 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-r8a7790-for-v3.10

for you to fetch changes up to ab5fdfd5ea621b629da9bfda987af301da973525:

  ARM: shmobile: force enable of r8a7790 arch timer (2013-04-09 21:37:36 +0900)

----------------------------------------------------------------
Renesas ARM based r8a7790 SoC update for v3.10

* Force architecture timer to be activated regardless of bootloader
  - This is necessary for the lager board to boot
* Add second memory range to r8a7790 PFC device
  - This is in preparation for further PFC work.
    It should not break anything as it is not used yet.

This pull request is based on:
git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git renesas-soc2-for-v3.10

----------------------------------------------------------------
Magnus Damm (2):
      ARM: shmobile: Add second I/O range for r8a7790 PFC
      ARM: shmobile: force enable of r8a7790 arch timer

 arch/arm/mach-shmobile/include/mach/r8a7790.h |    1 +
 arch/arm/mach-shmobile/setup-r8a7790.c        |   15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)
