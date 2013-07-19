From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 19 Jul 2013 13:35:53 +0900
Subject: [GIT] Renesas ARM based clocksource updates for v3.12
Message-ID: <cover.1374207810.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

please consider the following clocksource updates for v3.12.

The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:

  Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-clocksource-for-v3.12

for you to fetch changes up to 2792cc6f22031110f6959c02d42d7b6116105a71:

  clocksource: sh_cmt: 32-bit control register support (2013-07-16 10:42:23 +0900)

----------------------------------------------------------------
Renesas ARM based clocksource updates for v3.12

Add support for CMT hardware with 32-bit control and counter registers.

----------------------------------------------------------------
Magnus Damm (1):
      clocksource: sh_cmt: 32-bit control register support

 drivers/clocksource/sh_cmt.c |   50 ++++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 14 deletions(-)
