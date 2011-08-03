From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 3 Aug 2011 12:37:10 +0200
Subject: [PATCH v8 0/3] add the GPMI controller driver for IMX23/IMX28
In-Reply-To: <CAHMSPgM5W8=mE4sRDGMMfo39fvThBo_jrdG8hyhJNQ_ceV=_pA@mail.gmail.com>
References: <1311230846-26437-1-git-send-email-b32955@freescale.com>
	<20110721215020.GA25344@pengutronix.de>
	<4E28EEE1.2050008@freescale.com>
	<20110722055731.GI26837@S2100-06.ap.freescale.net>
	<4E292FCF.6010608@freescale.com>
	<CAHMSPgMHrqWcJ=BThDLgQ=XyTBDCMvNS4SVjQWfk=Jf682TEig@mail.gmail.com>
	<4E2F6F90.7030207@freescale.com>
	<CAHMSPgPC4whyskfuFGeFd7WHx-=5htezWajm_rNi9Xa+03PV0A@mail.gmail.com>
	<20018.24364.787244.956361@ipc1.ka-ro>
	<CAHMSPgM5W8=mE4sRDGMMfo39fvThBo_jrdG8hyhJNQ_ceV=_pA@mail.gmail.com>
Message-ID: <20110803103710.GA1948@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Do you have an SD card in the system? I'm getting the same error when
> > accessing an SD card. Without SD card I can use the flash without any
> > errors.
> 
> No SD card in the system. At least not on my mx23evk board.
> My real target hardware has a SDIO wifi chip.

Removing the SD didn't help here as well. Koen, which bootloader do you
use?

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110803/2c19e95c/attachment.sig>
