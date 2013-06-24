From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 24 Jun 2013 11:08:44 +0200
Subject: [PATCH 0/3] ARM: at91/PMC: some fixes for clock functionalies
Message-ID: <cover.1372064763.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It seems that some errors where made when affecting some functionalies to SoCs.

Please review this quickly as I do want to send these fixes for next merge
window with will open soon.

Best regards,

Nicolas Ferre (3):
  ARM: at91/PMC: sama5d3 family doesn't have a PLLB
  ARM: at91/PMC: at91sam9n12 family have a PLLB
  ARM: at91/PMC: at91sam9n12 family has USB HS feature

 arch/arm/mach-at91/clock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
1.8.2.2
