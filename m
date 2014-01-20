From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Mon, 20 Jan 2014 12:36:27 +0100
Subject: [PATCH v2] dma: imx-sdma: clarify firmare not found warning
In-Reply-To: <20140120122840.36520f37@ipc1.ka-ro>
References: <1390212438-6855-1-git-send-email-s.hauer@pengutronix.de>
 <20140120122840.36520f37@ipc1.ka-ro>
Message-ID: <20140120123627.1147f252@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Lothar Wa?mann wrote:
> Hi,
> 
erroneously pressed the 'Send' button...

> Sascha Hauer wrote:
> > When a firmware cannot be found for the SDMA engine then we can
> > continue with the inernal ROM firmware.
> > 
> > The meaning of this message is frequently asked for, so make clear
> > that the driver still works with the internal ROM firmware and reduce
> > the loglevel from err to info.
> > 
In case user space firmware loading support (CONFIG_FW_LOADER) is
enabled, this message may still be inadequate, since the firmware may
very well be loaded lateron.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
