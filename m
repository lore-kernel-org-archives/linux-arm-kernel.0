From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 8 Mar 2018 16:08:53 +0100
Subject: [PATCH 1/4] ARM: sunxi: mc-smp: Fix "lookback" typo
In-Reply-To: <20180308150012.19045-2-wens@csie.org>
References: <20180308150012.19045-1-wens@csie.org>
 <20180308150012.19045-2-wens@csie.org>
Message-ID: <20180308150853.masskeocuyl5mhp2@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 08, 2018 at 11:00:09PM +0800, Chen-Yu Tsai wrote:
> The sunxi_mc_smp_lookback function is modeled after the mcpm_loopback
> function in the MCPM framework. "lookback" was a typo introduced when
> the new function was added.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180308/cf7cb094/attachment.sig>
