From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Tue, 11 Feb 2014 21:34:36 +0100
Subject: [PATCH v4 0/2] [RESEND] Lager and Koelsch reference serial port
 support
Message-ID: <1392150878-10436-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch set enables the serial port DT devices for the Lager and Koelsch
reference boards.

The previous "[PATCH v3 0/4] Lager and Koelsch reference serial port support"
series that contained these two patches got partially merged in v3.14-rc1. This
is a resent of the left-overs that we have decided to push back to v3.15,
rebased on top of Simon's latest devel branch.

Laurent Pinchart (2):
  ARM: shmobile: lager: Enable SCIF0 and SCIF1 serial ports in DT
  ARM: shmobile: koelsch: Enable SCIF0 and SCIF1 serial ports in DT

 arch/arm/boot/dts/r8a7790-lager.dts              | 24 ++++++++++++++---
 arch/arm/boot/dts/r8a7791-koelsch.dts            | 24 ++++++++++++++---
 arch/arm/mach-shmobile/board-koelsch-reference.c | 18 ++-----------
 arch/arm/mach-shmobile/board-lager-reference.c   | 18 ++-----------
 arch/arm/mach-shmobile/clock-r8a7790.c           | 16 +++++------
 arch/arm/mach-shmobile/clock-r8a7791.c           | 24 ++++++++---------
 arch/arm/mach-shmobile/setup-r8a7790.c           | 26 +++++++++---------
 arch/arm/mach-shmobile/setup-r8a7791.c           | 34 ++++++++++++------------
 8 files changed, 94 insertions(+), 90 deletions(-)

-- 
Regards,

Laurent Pinchart
