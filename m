From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 8 Mar 2018 16:09:44 +0100
Subject: [PATCH 3/4] ARM: dts: sun9i: Add enable-method for SMP support
 for the A80 SoC
In-Reply-To: <20180308150012.19045-4-wens@csie.org>
References: <20180308150012.19045-1-wens@csie.org>
 <20180308150012.19045-4-wens@csie.org>
Message-ID: <20180308150944.mlkgsrwhsk7hrlcp@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 08, 2018 at 11:00:11PM +0800, Chen-Yu Tsai wrote:
> Using the enable-method property for SMP support would allow future PSCI
> implementations to override any in-OS support. This is better than just
> matching against the machine compatible, and then having to determine
> whether other methods are available or not.
> 
> This adds enable-method properties to all CPU nodes.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180308/10a5f26d/attachment.sig>
