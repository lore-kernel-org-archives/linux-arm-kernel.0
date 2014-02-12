From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 12 Feb 2014 20:22:43 +0100
Subject: [PATCH] pinctrl: sunxi: use chained_irq_{enter, exit} for GIC
 compatibility
In-Reply-To: <1392049357-13225-1-git-send-email-wens@csie.org>
References: <1392049357-13225-1-git-send-email-wens@csie.org>
Message-ID: <20140212192243.GC9812@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 12:22:37AM +0800, Chen-Yu Tsai wrote:
> On tha Allwinner A20 SoC, the external interrupts on the pin controller
> device are connected to the GIC. Without chained_irq_{enter, exit},
> external GPIO interrupts, such as used by mmc core card detect, cause
> the system to hang.
> 
> Cc: stable at vger.kernel.org
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140212/56433c62/attachment.sig>
