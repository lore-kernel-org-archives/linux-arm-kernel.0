From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 17 Jan 2011 18:50:55 +0100
Subject: [PATCH v2] Add i.MX23/28 auart support
In-Reply-To: <20110117112508.GA23185@freescale.com>
References: <1294924476-10653-1-git-send-email-s.hauer@pengutronix.de>
	<20110117112508.GA23185@freescale.com>
Message-ID: <20110117175055.GK9041@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 17, 2011 at 07:25:09PM +0800, Shawn Guo wrote:
> Hi Sascha,
> 
> I tested the patch on mx28 evk with auart0 and auart3 connected with
> cross cable, and it works.  But when I try to get console on auart0
> with a direct-connecting cable, I do not see anything on console.
> 
> Did you verify it works for console?

Yes, I did, but I can recheck in case I broke something in the latest
version. What did you pass as console= in the kernel command line?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
