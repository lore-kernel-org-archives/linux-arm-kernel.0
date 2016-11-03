From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 3 Nov 2016 09:26:57 +0100
Subject: [PATCH v2 05/14] ASoC: sun4i-codec: Add support for optional
 reset control to quirks
In-Reply-To: <20161103075556.29018-6-wens@csie.org>
References: <20161103075556.29018-1-wens@csie.org>
 <20161103075556.29018-6-wens@csie.org>
Message-ID: <20161103082656.xhf7d7wguwbi3rsx@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 03, 2016 at 03:55:47PM +0800, Chen-Yu Tsai wrote:
> The later Allwinner SoCs have a dedicated reset controller, and
> peripherals have dedicated reset controls which need to be deasserted
> before the associated peripheral can be used.
> 
> Add support for this to the quirks structure and probe/remove functions.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161103/dcaed374/attachment.sig>
