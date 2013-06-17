From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 17 Jun 2013 18:28:46 +0900
Subject: [GIT PULL v3 0/3] Renesas sh-sci updates for v3.11
Message-ID: <1371461329-26467-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

As requested the first patch is now includes an ack from Greg
Kroah-Hartman.

This pull request is based on renesas-soc2-for-v3.11, which you have
already pulled, in order to satisfy dependencies.

The second patch in the series is provided here because it
has a build-time dependency in the first patch of the series.

The third patch of the series could be applied independently,
for instance as part of a fresh soc pull request, but it seems
just as well to include it here.

The following changes since commit 018222f5d32bc5ca9fd830aebfeed10f1be96c93:

  ARM: shmobile: r8a7790: add clock definitions and aliases for MMCIF and SDHI (2013-06-12 21:07:38 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-sh-sci-for-v3.11

for you to fetch changes up to c972f024c1097fa0798beafc21be1eeeba21ac34:

  ARM: shmobile: r8a7790: don't use external clock for SCIFs (2013-06-17 18:09:54 +0900)

----------------------------------------------------------------
Renesas sh-sci updates for v3.11

HSCIF support by Ulrich Hecht.

----------------------------------------------------------------
Ulrich Hecht (3):
      serial: sh-sci: HSCIF support
      ARM: shmobile: r8a7790: HSCIF support
      ARM: shmobile: r8a7790: don't use external clock for SCIFs

 arch/arm/mach-shmobile/setup-r8a7790.c |   16 ++++-
 drivers/tty/serial/sh-sci.c            |  102 +++++++++++++++++++++++++++++---
 include/linux/serial_sci.h             |   12 +++-
 include/uapi/linux/serial_core.h       |    3 +
 4 files changed, 120 insertions(+), 13 deletions(-)
