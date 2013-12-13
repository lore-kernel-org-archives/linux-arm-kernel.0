From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:28:37 +0900
Subject: [GIT PULL] Renesas USB r8a66597 HCD update for v3.14
Message-ID: <cover.1386898134.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

please consider this Renesas USB r8a66597 HCD update for v3.14

It has been acked by Greg Kroah-Hartman.
I would like it to go through the arm-soc tree as it
is a dependency for forthcoming CCF changes.

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-usb-r8a66597-hcd-for-v3.14

for you to fetch changes up to 9b547a882e9ffec67bb41a4e66b4bcc0e91a2737:

  usb: r8a66597-hcd: Convert to clk_prepare/unprepare (2013-11-28 17:19:11 +0900)

----------------------------------------------------------------
Renesas USB r8a66597 HCD update for v3.14

Convert to clk_prepare/unprepare

----------------------------------------------------------------
Laurent Pinchart (1):
      usb: r8a66597-hcd: Convert to clk_prepare/unprepare

 drivers/usb/host/r8a66597-hcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
