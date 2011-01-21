From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 21 Jan 2011 11:57:51 +0100
Subject: i.MX28 fixes
Message-ID: <1295607474-6559-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patches fix some issues with the i.MX28 clock support.

The following changes since commit c56eb8fb6dccb83d9fe62fd4dc00c834de9bc470:

  Linux 2.6.38-rc1 (2011-01-18 15:14:02 -0800)

are available in the git repository at:
  none ..BRANCH.NOT.VERIFIED..

Sascha Hauer (3):
      ARM i.MX28: fix bit operation
      ARM i.MX28: use correct register for setting the rate
      ARM i.MX23/28: remove secondary field from struct clk. It's unused

 arch/arm/mach-mxs/clock-mx28.c         |    4 ++--
 arch/arm/mach-mxs/clock.c              |    2 --
 arch/arm/mach-mxs/include/mach/clock.h |    2 --
 3 files changed, 2 insertions(+), 6 deletions(-)
