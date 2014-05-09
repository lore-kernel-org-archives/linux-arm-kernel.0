From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 9 May 2014 08:18:21 +0200
Subject: [PATCH] ARM i.MX51: Add Efika MX Smartbook devicetree
In-Reply-To: <CAOMZO5AbKxzre0vMNcAyk5u2Cmwt8fbiAUSgqVpiLkuigvXzpQ@mail.gmail.com>
References: <1397641298-25392-1-git-send-email-shc_work@mail.ru>
 <20140508062616.GF5918@pengutronix.de>
 <CAOMZO5AbKxzre0vMNcAyk5u2Cmwt8fbiAUSgqVpiLkuigvXzpQ@mail.gmail.com>
Message-ID: <20140509061821.GQ5858@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 09, 2014 at 12:11:32AM -0300, Fabio Estevam wrote:
> On Thu, May 8, 2014 at 3:26 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> 
> > From what I can see ulpi mode is not supported currently in the chipidea
> > driver. I think that shouldn't block adding these device nodes, but
> 
> It works with usb nop transceiver. We got it running on mx27pdk,
> mx51evk and other boards.

The ULPI phys need to be configured. I don't think that it works on the
Efika without additional code. But now that the chipidea patches are
flowing into the kernel again I may find some motivation to have a look
into this issue.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
