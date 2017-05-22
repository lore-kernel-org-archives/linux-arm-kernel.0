From: sebastian.reichel@collabora.co.uk (Sebastian Reichel)
Date: Mon, 22 May 2017 12:27:19 +0200
Subject: [PATCH 3/3] mfd: twl: move header file out of I2C realm
In-Reply-To: <20170521220212.1404-4-wsa@the-dreams.de>
References: <20170521220212.1404-1-wsa@the-dreams.de>
 <20170521220212.1404-4-wsa@the-dreams.de>
Message-ID: <20170522102719.yzqujz327hv5zu7r@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, May 22, 2017 at 12:02:10AM +0200, Wolfram Sang wrote:
> include/linux/i2c is not for client devices. Move the header file to a
> more appropriate location.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
> [...]
>  drivers/power/supply/twl4030_charger.c  | 2 +-
> [...]

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170522/32401596/attachment.sig>
