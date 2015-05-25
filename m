From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 25 May 2015 10:24:07 +0200
Subject: [RESEND PATCH v1 2/2] drm: bridge/dw_hdmi-i2s-audio: add audio
 driver
In-Reply-To: <1432307696-7806-1-git-send-email-ykk@rock-chips.com>
References: <1432307631-7667-1-git-send-email-ykk@rock-chips.com>
 <1432307696-7806-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1432542247.27695.137.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just a nit: a license mismatch.

On Fri, 2015-05-22 at 10:14 -0500, Yakir Yang wrote:
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/dw_hdmi-i2s-audio.c

> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.

This states the license is GPL v2.

> +MODULE_LICENSE("GPL");

And, according to include/linux/module.h, this states the license is GPL
v2 or later. So I think that either the comment at the top of this file
or the ident used in the MODULE_LICENSE() macro should change.


Paul Bolle
