From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 26 Jun 2013 16:13:08 +0200
Subject: [PATCH 03/16] ARM: dts: i.MX6qdl: Add i.MX31 compatible to gpt
 node
In-Reply-To: <20130626135920.GB21845@S2101-09.ap.freescale.net>
References: <1372168320-22605-1-git-send-email-s.hauer@pengutronix.de>
 <1372168320-22605-4-git-send-email-s.hauer@pengutronix.de>
 <20130626135920.GB21845@S2101-09.ap.freescale.net>
Message-ID: <20130626141308.GA516@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 26, 2013 at 09:59:21PM +0800, Shawn Guo wrote:
> On Tue, Jun 25, 2013 at 03:51:47PM +0200, Sascha Hauer wrote:
> > The i.MX6 gpt is handled by the i.MX31 gpt driver in the kernel,
> 
> Just out of curiosity, where is the gpt driver you are talking about?

In barebox. In the kernel we have mxc_timer_init() which I called
'driver', but the i.MX6 uses the same codepath as i.MX31.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
