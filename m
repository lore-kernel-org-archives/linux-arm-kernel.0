From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 4 Jan 2018 14:27:52 +0100
Subject: [PATCH] ARM: dts: sun[47]i: Fix display backend 1 output to
 TCON0 remote endpoint
In-Reply-To: <20180103163155.13975-1-wens@csie.org>
References: <20180103163155.13975-1-wens@csie.org>
Message-ID: <20180104132752.pcixtjugwfvlshpl@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 04, 2018 at 12:31:55AM +0800, Chen-Yu Tsai wrote:
> There is a copy-paste error in the display pipeline device tree graph.
> The remote endpoint of the display backend 1's output to TCON0 points
> to the wrong endpoint. This will result in the driver incorrectly
> parsing the relationship of the components.
> 
> Reported-by: Andrea Venturi <ennesimamail.av@gmail.com>
> Fixes: 0df4cf33a594 ("ARM: dts: sun4i: Add device nodes for display
> 		      pipelines")
> Fixes: 5b92b29bed45 ("ARM: dts: sun7i: Add device nodes for display
> 		      pipelines")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180104/f70c36ad/attachment.sig>
