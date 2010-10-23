From: eballetbo@gmail.com (Enric Balletbo i Serra)
Date: Sat, 23 Oct 2010 18:48:57 +0200
Subject: [PATCHv2 0/3] Various code improvements for IGEP v2 board.
Message-ID: <1287852540-4951-1-git-send-email-eballetbo@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hello,

The comments of this post also apply to IGEP v2 board (thanks Laurent)

  http://www.mail-archive.com/linux-omap at vger.kernel.org/msg36402.html

Changes since v1:
 - Split patch in a serie.
 - [1/3] onenand_setup = NULL, is a static variable, removed from code.

This patch apply on top of tmlind/omap-for-linux branch.

$ git diff --stat tmlind/omap-for-linus 
 arch/arm/mach-omap2/board-igep0020.c |   35 ++++++++++-----------------------
 1 files changed, 11 insertions(+), 24 deletions(-)

Cheers,
  Enric
