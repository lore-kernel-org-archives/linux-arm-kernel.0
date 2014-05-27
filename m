From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 27 May 2014 10:40:41 +0200
Subject: [PATCH] ARM: sunxi: allow building without reset controller
In-Reply-To: <4307148.6KkdViVLZk@wuerfel>
References: <4307148.6KkdViVLZk@wuerfel>
Message-ID: <20140527084041.GH4730@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Mon, May 26, 2014 at 05:19:03PM +0200, Arnd Bergmann wrote:
> The sunxi reset controller code is only used with sun6i (a31).
> After the platform has been split up into per-soc options, it's
> now possible to build it without the reset controller code, so
> the base platform init must not call into the reset driver
> if that is turned off at compile time.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Can you apply it directly in arm-soc?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140527/62394c7a/attachment.sig>
