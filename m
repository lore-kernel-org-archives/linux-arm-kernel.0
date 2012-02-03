From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Feb 2012 19:15:28 +0000
Subject: [PATCH 0/3] SA11x0 fixes
Message-ID: <20120203191528.GE14129@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of three patches fix a number of issues I've noticed while
looking at the SA11x0 code - they're all trivial in nature, so I don't
think too much additional explaination is required.

 arch/arm/common/sa1111.c          |    2 +-
 arch/arm/mach-sa1100/generic.c    |    4 ++--
 arch/arm/mach-sa1100/hackkit.c    |    2 +-
 arch/arm/mach-sa1100/jornada720.c |    8 ++++----
 arch/arm/mach-sa1100/sleep.S      |   37 ++++++++++++++++++++++---------------
 5 files changed, 30 insertions(+), 23 deletions(-)
