From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 18 Jul 2014 10:11:34 +0200
Subject: [PATCH 2/5] rtc: sunxi: Depend on platforms sun4i/sun7i that
 actually have the rtc
In-Reply-To: <1405323137-24287-3-git-send-email-wens@csie.org>
References: <1405323137-24287-1-git-send-email-wens@csie.org>
 <1405323137-24287-3-git-send-email-wens@csie.org>
Message-ID: <20140718081134.GJ20328@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 14, 2014 at 03:32:14PM +0800, Chen-Yu Tsai wrote:
> Now that we have Kconfig options for individual sunxi platforms, let
> the rtc-sunxi driver depend on the platforms that actually have this
> hardware, sun4i and sun7i.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140718/0a7c12ae/attachment.sig>
