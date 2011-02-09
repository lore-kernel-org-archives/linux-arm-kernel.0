From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Wed, 9 Feb 2011 14:13:04 +0100
Subject: [PATCH 1/5] dmaengine: mxs-dma: add dma support for i.MX23/28
In-Reply-To: <20110209204223.GA7417@S2100-06.ap.freescale.net>
References: <1296871696-21008-2-git-send-email-shawn.guo@freescale.com>
	<19793.22067.960689.669543@ipc1.ka-ro>
	<20110209001710.GF6963@S2100-06.ap.freescale.net>
	<19794.19192.351501.395360@ipc1.ka-ro>
	<20110209204223.GA7417@S2100-06.ap.freescale.net>
Message-ID: <19794.37600.437618.46182@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Shawn Guo writes:
> On Wed, Feb 09, 2011 at 09:06:16AM +0100, Lothar Wa?mann wrote:
[...]
> > You could use the SSP IRQ as well.
> > 
> No, I could not.  The SSP IRQ (e.g. MX28_INT_SSP0_ERROR) is designed
> to indicate an error condition than the completion of mmc command.
> 
Ah, ok. That's the 'advantage' of not having a dedicated MMC/SD
controller, but adding some MMC capabilities to the SSP controller.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
