From: alan@signal11.us (Alan Ott)
Date: Sat, 10 Mar 2012 16:36:20 -0500
Subject: [PATCH v2 0/2] ata: AT91 ata driver requires specific platforms
In-Reply-To: <1331405617-4053-1-git-send-email-alan@signal11.us>
References: <1331405617-4053-1-git-send-email-alan@signal11.us>
Message-ID: <1331415380-10928-1-git-send-email-alan@signal11.us>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on suggestions from Ben Dooks, This patch now adds an AT91_HAS_PATA
kconfig item and the AT91 CPUs which have PATA now select it. The
AT91 PATA driver how depends on this kconfig item.

Ben, let me know if this is what you had in mind.


Alan Ott (2):
  ARM: AT91: Add parameter for AT91_HAS_PATA
  ata: AT91 ata driver requires AT91_HAS_PATA

 arch/arm/mach-at91/Kconfig |   11 +++++++++++
 drivers/ata/Kconfig        |    1 +
 2 files changed, 12 insertions(+), 0 deletions(-)
