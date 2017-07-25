From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 25 Jul 2017 09:33:11 +0200
Subject: [PATCH v3 03/10] clk: sunxi-ng: a83t: Support new timing mode
 for mmc2 clock
In-Reply-To: <20170724135905.28855-4-wens@csie.org>
References: <20170724135905.28855-1-wens@csie.org>
 <20170724135905.28855-4-wens@csie.org>
Message-ID: <20170725073311.kyfsvf4xzrzlhgp5@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 24, 2017 at 09:58:58PM +0800, Chen-Yu Tsai wrote:
> The MMC2 clock supports a new timing mode. When the new mode is active,
> the output clock rate is halved.
> 
> This patch sets the feature flag for the new timing mode, and adds
> a pre-divider based on the mode bit.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170725/5bac807b/attachment.sig>
