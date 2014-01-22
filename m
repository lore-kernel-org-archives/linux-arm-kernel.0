From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 22 Jan 2014 07:51:51 +0100
Subject: [PATCH RFC v4 10/10] ahci_imx: Port to library-ised ahci_platform
In-Reply-To: <1390236303-22538-11-git-send-email-hdegoede@redhat.com>
References: <1390236303-22538-1-git-send-email-hdegoede@redhat.com>
 <1390236303-22538-11-git-send-email-hdegoede@redhat.com>
Message-ID: <20140122065151.GC16215@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Mon, Jan 20, 2014 at 05:45:03PM +0100, Hans de Goede wrote:
> This avoids the ugliness of creating a nested platform device from probe.
> 
> Note untested, I've ordered a wandboard to be able to test these changes.

Looks much better now, thanks. I could test this patch aswell, no need
to buy new hardware for this.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
