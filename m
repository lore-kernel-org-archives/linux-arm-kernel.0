From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 21 Jan 2014 08:06:49 +0100
Subject: [PATCH v2] dma: imx-sdma: clarify firmare not found warning
In-Reply-To: <20140120123627.1147f252@ipc1.ka-ro>
References: <1390212438-6855-1-git-send-email-s.hauer@pengutronix.de>
 <20140120122840.36520f37@ipc1.ka-ro>
 <20140120123627.1147f252@ipc1.ka-ro>
Message-ID: <20140121070649.GT16215@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lothar,

On Mon, Jan 20, 2014 at 12:36:27PM +0100, Lothar Wa?mann wrote:
> Hi,
> 
> Lothar Wa?mann wrote:
> > Hi,
> > 
> erroneously pressed the 'Send' button...
> 
> > Sascha Hauer wrote:
> > > When a firmware cannot be found for the SDMA engine then we can
> > > continue with the inernal ROM firmware.
> > > 
> > > The meaning of this message is frequently asked for, so make clear
> > > that the driver still works with the internal ROM firmware and reduce
> > > the loglevel from err to info.
> > > 
> In case user space firmware loading support (CONFIG_FW_LOADER) is
> enabled, this message may still be inadequate, since the firmware may
> very well be loaded lateron.

Then at least until the RAM firmware is loaded the message is still adequate,
no? We could add an addional message when the firmware is loaded if you
like.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
