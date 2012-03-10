From: alan@signal11.us (Alan Ott)
Date: Sat, 10 Mar 2012 18:14:41 -0500
Subject: [PATCH v2 0/1] ARM: AT91: cleanup patches from Arnd Bergmann
In-Reply-To: <1331405049-3186-1-git-send-email-alan@signal11.us>
References: <1331405049-3186-1-git-send-email-alan@signal11.us>
Message-ID: <1331421281-11570-1-git-send-email-alan@signal11.us>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Version 2 of the patchset.
	* NO_IOPORT for RM9200 patch has been removed.
	* Hopefully all the right people are on this one.

Arnd Bergmann (1):
  ARM: at91: Use proper __iomem annotations

 arch/arm/mach-at91/at91rm9200.c            |    2 +-
 arch/arm/mach-at91/include/mach/hardware.h |    4 ++++
 arch/arm/mach-at91/setup.c                 |    4 ++--
 3 files changed, 7 insertions(+), 3 deletions(-)
