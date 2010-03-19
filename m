From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 19 Mar 2010 11:28:40 +0100
Subject: [RFC] i.MX51 patches
Message-ID: <1268994525-32495-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here are some patches for review.

Sascha

The following changes since commit a3d3203e4bb40f253b1541e310dc0f9305be7c84:
  Linus Torvalds (1):
        Merge branch 'release' of git://git.kernel.org/.../lenb/linux-acpi-2.6

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git mx51

Sascha Hauer (5):
      i.MX51 Babbage: Add uncompress output
      i.MX51: Use correct clock for gpt
      i.MX51: map TZIC dynamically
      i.MX51: determine silicon revision dynamically
      i.MX51: remove NFC AXI static mapping

 arch/arm/mach-mx5/clock-mx51.c              |    2 +-
 arch/arm/mach-mx5/cpu.c                     |   53 +++++++++++++++++++++++++++
 arch/arm/mach-mx5/mm.c                      |   32 +++++++----------
 arch/arm/plat-mxc/include/mach/mx51.h       |   33 ++++++-----------
 arch/arm/plat-mxc/include/mach/uncompress.h |    4 ++
 5 files changed, 83 insertions(+), 41 deletions(-)
