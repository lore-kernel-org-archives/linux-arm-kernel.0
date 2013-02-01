From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 1 Feb 2013 08:36:14 +0100
Subject: [PATCH] USB chipidea i.MX: use framework phy handling
In-Reply-To: <1359631937-26646-1-git-send-email-s.hauer@pengutronix.de>
References: <1359631937-26646-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20130201073614.GX1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 12:32:15PM +0100, Sascha Hauer wrote:
> This series switches the mxs phy and the i.MX chipidea support
> from homegrew phy support to use usb_add_phy_dev/devm_usb_get_phy_by_phandle.
> 
> Based on
> 
> [PATCH v2] Add USB of helpers and use them in the chipidea driver
> 
> But I think this could also be applied separately if necessary.

Kishon, Peter,

Thanks for reviewing these, but I'm afraid I must send another iteration
for these. These patches do not handle -EPROBE_DEFER correctly.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
