From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 10 Aug 2015 12:33:34 +0300
Subject: [PATCH] ARM/fb: ep93xx: switch framebuffer to use modedb only
In-Reply-To: <1437744688-29915-1-git-send-email-linus.walleij@linaro.org>
References: <1437744688-29915-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <55C86FEE.6090502@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 24/07/15 16:31, Linus Walleij wrote:
> All the EP93xx boards exclusively use modedb to look up video
> modes from the command line. Root out the parametrization of
> custom video modes from the platform data and board files
> and simplify the driver.
> 
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> J-C/Tomi: please ACK this if you're OK with it so I can take
> it through the ARM SoC tree.

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150810/340ad3f3/attachment.sig>
