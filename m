From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 26 Apr 2012 15:02:22 +0200
Subject: [PATCH 31/33] ARM i.MX5: implement clocks using common clock
 framework
In-Reply-To: <201204261448.00925.heiko@sntech.de>
References: <1335367703-19929-1-git-send-email-s.hauer@pengutronix.de>
 <1335367703-19929-32-git-send-email-s.hauer@pengutronix.de>
 <201204261448.00925.heiko@sntech.de>
Message-ID: <20120426130222.GI17184@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2012 at 02:48:00PM +0200, Heiko St?bner wrote:
> Hi Sascha,
> 
> more out of curiosity, why is the i.MX50 always excluded. Is it so vastly
> different to the MX51 and MX53?

I don't think that it's so different. I think the reason is that the
i.MX50 is not widely used outside of some special applications. At least
we have no customers using it.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
