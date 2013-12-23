From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Dec 2013 11:08:41 +0900
Subject: [GIT PULL 0/3] Renesas SH SCI updates for v3.14
Message-ID: <cover.1387761495.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin, Hi Olof, Hi Arnd,

please consider these Renesas SH SCI updates for v3.14.

They have been acked by Greg Kroah-Hartman to be taken
through my tree. The reason for this is that they are dependencies
for subsequent changes to use the common clock framework.


The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-sh-sci-for-v3.14

for you to fetch changes up to b016b646e8676858f39ea9be760494b04b9ee0af:

  serial: sh-sci: Convert to clk_prepare/unprepare (2013-12-14 09:59:31 +0900)

----------------------------------------------------------------
Renesas SH SCI updates for v3.14

Updates for the SH SCI serial driver

* Convert to clk_prepare/unprepare
* Fix warnings due to improper casts and printk formats

----------------------------------------------------------------
Laurent Pinchart (3):
      serial: sh-sci: Fix warnings due to improper casts and printk formats
      serial: sh-sci: Don't enable/disable port from within break timer
      serial: sh-sci: Convert to clk_prepare/unprepare

 drivers/tty/serial/sh-sci.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)
