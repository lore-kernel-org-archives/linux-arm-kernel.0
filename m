From: nathan_lynch@mentor.com (Nathan Lynch)
Date: Mon, 18 May 2015 12:43:44 -0500
Subject: [PATCH 0/2] ARM: VDSO: clean up linker flags, cope with gold
Message-ID: <1431971026-18317-1-git-send-email-nathan_lynch@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A couple patches to clean up the VDSO Makefile's use of linker
directives and handle toolchains which default to using the gold
linker.

Nathan Lynch (2):
  ARM: VDSO: group link options
  ARM: VDSO: force use of BFD linker

 arch/arm/vdso/Makefile | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

-- 
2.1.0
