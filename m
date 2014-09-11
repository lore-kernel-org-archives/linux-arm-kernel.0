From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 11 Sep 2014 23:02:11 +0200
Subject: [PATCH 3/7] clk: sunxi: unify sun6i AHB1 clock with proper PLL6
 pre-divider
In-Reply-To: <1410000448-9999-4-git-send-email-wens@csie.org>
References: <1410000448-9999-1-git-send-email-wens@csie.org>
 <1410000448-9999-4-git-send-email-wens@csie.org>
Message-ID: <20140911210211.GM31276@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Sep 06, 2014 at 06:47:24PM +0800, Chen-Yu Tsai wrote:
> This patch unifies the sun6i AHB1 clock, originally supported
> with separate mux and divider clks. It also adds support for
> the pre-divider on the PLL6 input, thus allowing the clock to
> be muxed to PLL6 with proper clock rate calculation.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

It looks fine, but I'd rather see this in a separate file, especially
since we don't seem to have any order dependency.

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
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140911/03a0bc3f/attachment.sig>
