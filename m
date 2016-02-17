From: broonie@kernel.org (Mark Brown)
Date: Wed, 17 Feb 2016 10:53:40 +0000
Subject: [PATCH] spi/rockchip: Add dt-binding for Rockchip rk3399 spi
In-Reply-To: <4579617.rz6Yi2sU5M@phil>
References: <1455614538-4415-1-git-send-email-jay.xu@rock-chips.com>
 <1730751.NYv1NxJVuB@phil> <56C3BD26.3030704@rock-chips.com>
 <4579617.rz6Yi2sU5M@phil>
Message-ID: <20160217105340.GI7544@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2016 at 07:45:09AM +0100, Heiko Stuebner wrote:

> That was meant as a reply to Mark's comment, explaining why the double 
> compatible and the driver only binding to the rk3066-one right now.

It's still better to have the compatible explicitly listed in the
driver even if it doesn't change the configuration at all at this time.
That way we've at least got a record that the handling is currently
identical to whatever other devices it is the same as.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160217/2ce71edf/attachment.sig>
