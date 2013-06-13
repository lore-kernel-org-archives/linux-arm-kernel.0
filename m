From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Jun 2013 16:00:52 +0900
Subject: [GIT PULL 0/2] Renesas sh-sci updates for v3.11
Message-ID: <1371106854-25560-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

I have included the r8a7790 change in this patch as it
depends on the first change in the pull-request but nothing else.

This pull request will cause some conflicts though I believe all
of them are not difficult to resolve. The renesas-next-20130613 tag in
my tree illustrates how I have handled the conflicts with
both changes already in arm-soc and changes I intend to send
pull requests for in the near future.

The following changes since commit c7788792a5e7b0d5d7f96d0766b4cb6112d47d75:

  Linux 3.10-rc2 (2013-05-20 14:37:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git sh-sci

for you to fetch changes up to d1b6515e2eeaac48eff47bf4987f106a982e14f3:

  ARM: shmobile: r8a7790: don't use external clock for SCIFs (2013-06-11 17:24:08 +0900)

----------------------------------------------------------------
Renesas sh-sci updates for v3.11

HSCIF support by Ulrich Hecht.

----------------------------------------------------------------
Ulrich Hecht (2):
      serial: sh-sci: HSCIF support
      ARM: shmobile: r8a7790: don't use external clock for SCIFs

 arch/arm/mach-shmobile/setup-r8a7790.c |  16 +++++-
 drivers/tty/serial/sh-sci.c            | 102 ++++++++++++++++++++++++++++++---
 include/linux/serial_sci.h             |  12 +++-
 include/uapi/linux/serial_core.h       |   3 +
 4 files changed, 120 insertions(+), 13 deletions(-)
