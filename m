From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 May 2012 18:50:54 +0000
Subject: [PATCH] ARM: at91: Add ADC driver to at91sam9260/at91sam9g20 dtsi
 files
In-Reply-To: <1337182626-13033-1-git-send-email-nicolas.ferre@atmel.com>
References: <4FB3B1F3.6080102@atmel.com>
 <1337182626-13033-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <201205161850.54765.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 May 2012, Nicolas Ferre wrote:
> Now that the bulk of at91sam9g20-related nodes are located in at91sam9260.dtsi,
> we have to re-create the path to this ADC node for SoC specific parts.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Should we apply this patch in arm-soc so that Greg can drop the hunk that
no longer applies?

	Arnd
