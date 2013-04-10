From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 10 Apr 2013 13:51:14 +0900
Subject: [GIT PULL] Renesas ARM and SH based SoC pinmux fixes for v3.10 
Message-ID: <1365569475-28721-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Hi Olof,

The following changes since commit 202ac6a21a79500ef5aab4cd8665be2597e9345c:

  sh-pfc: r8a73a4: Remove unused GPIO bias data (2013-04-03 10:30:43 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas tags/renesas-pinmux-fixes-for-v3.10

for you to fetch changes up to 407cd59798ff3ee2b3acdc149adf1f10fe8a098c:

  sh-pfc: r8a7779: tidyup intc_irq3_b typo (2013-04-09 17:56:08 +0900)

----------------------------------------------------------------
Renesas ARM and SH based SoC pinmux fixes for v3.10

Correct a typo in sh-pfc r8a7779

----------------------------------------------------------------
Kuninori Morimoto (1):
      sh-pfc: r8a7779: tidyup intc_irq3_b typo

 drivers/pinctrl/sh-pfc/pfc-r8a7779.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
