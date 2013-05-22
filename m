From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 22 May 2013 15:48:09 +0900
Subject: [GIT PULL] Renesas ARM SoC based marzen board fix for v3.10
Message-ID: <1369205290-6272-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Hi Olof,

please consider the following fix for v3.10.
It resolves a boot-failure regression on the marzen board.

The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-boards-marzen-fixes-for-v3.10

for you to fetch changes up to 5f10428e4a6d99cc019270c51ad5a33fb38addeb:

  ARM: shmobile: marzen: Use error values in usb_power_* (2013-05-22 15:43:16 +0900)

----------------------------------------------------------------
Correct USB PHY initialisation on the marzen board.

----------------------------------------------------------------
Simon Horman (1):
      ARM: shmobile: marzen: Use error values in usb_power_*

 arch/arm/mach-shmobile/board-marzen.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
