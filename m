From: horms+renesas@verge.net.au (Simon Horman)
Date: Sat, 25 May 2013 15:42:17 +0900
Subject: [GIT PULL] Renesas ARM sh73a0 SoC fix for v3.10 (repost)
Message-ID: <1369464138-21530-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ Repost after hopefully resolving a local mail configuration problem ]

Hi Arnd, Hi Olof,

The following changes since commit c7788792a5e7b0d5d7f96d0766b4cb6112d47d75:

  Linux 3.10-rc2 (2013-05-20 14:37:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-sh73a0-fixes-for-v3.10

for you to fetch changes up to 5f17a516534924d40e6e0a24dcfd06e397a68485:

  ARM: shmobile: sh73a0: Update CMT clockevent rating to 80 (2013-05-22 23:47:48 +0900)

----------------------------------------------------------------
Update CMT clock rating for sh73a0 SoC to resolve boot failure
on kzm9g-reference. This resolves a regression between v3.9 and v3.10-rc1.

----------------------------------------------------------------
Simon Horman (1):
      ARM: shmobile: sh73a0: Update CMT clockevent rating to 80

 arch/arm/mach-shmobile/setup-sh73a0.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
