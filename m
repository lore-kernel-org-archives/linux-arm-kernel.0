From: horms+renesas@verge.net.au (Simon Horman)
Date: Sat, 16 Feb 2013 11:25:52 +0900
Subject: GIT PULL] Renesas ARM-based SoC pinmux for v3.9 #2
Message-ID: <1360981553-11414-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

The following changes since commit c3323806a67c0c656e27956b7340e37ba6c6968b:

  sh-pfc: Move sh_pfc.h from include/linux/ to driver directory (2013-01-25 09:24:31 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-pinmux2-for-v3.9

for you to fetch changes up to 8c43fcc7804fc4609ccd9fa021e21f5423db9d96:

  sh-pfc: sh_pfc_probe() sizeof() fix (2013-02-16 10:58:50 +0900)

----------------------------------------------------------------
Bug fix from Magnus that resolves a regression introduced in pfc changes
queued up for 3.9.

----------------------------------------------------------------
Magnus Damm (1):
      sh-pfc: sh_pfc_probe() sizeof() fix

 drivers/pinctrl/sh-pfc/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
