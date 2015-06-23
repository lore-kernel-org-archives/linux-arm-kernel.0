From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 23 Jun 2015 07:53:51 +0200
Subject: [RESEND PATCH 2/6] soc: Mediatek: Add SCPSYS CPU power domain
 driver
In-Reply-To: <1434650481-39421-3-git-send-email-scott.shu@mediatek.com>
References: <srv_scott.shu@mediatek.com>
 <1434650481-39421-1-git-send-email-scott.shu@mediatek.com>
 <1434650481-39421-3-git-send-email-scott.shu@mediatek.com>
Message-ID: <20150623055351.GA22419@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Scott,

On Fri, Jun 19, 2015 at 02:01:17AM +0800, Scott Shu wrote:
> This adds a CPU power domain driver for the Mediatek SCPSYS unit on
> MT6580.

This seems to be support for the very same hardware as I am posting
here:

https://lkml.org/lkml/2015/6/22/41

We should consolidate this.

My driver is currently handles all power domains except the CPUs while
yours handles only the CPUs.
I currently haven't looked whether CPUs can just be part of a power
domain aswell, but if that works this would probably be the way to go.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
