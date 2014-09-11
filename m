From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 11 Sep 2014 22:36:49 +0200
Subject: [PATCH 1/7] clk: sunxi: Add post clk divider for factor clocks
In-Reply-To: <1410000448-9999-2-git-send-email-wens@csie.org>
References: <1410000448-9999-1-git-send-email-wens@csie.org>
 <1410000448-9999-2-git-send-email-wens@csie.org>
Message-ID: <20140911203649.GK31276@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 06, 2014 at 06:47:22PM +0800, Chen-Yu Tsai wrote:
> Some factor clocks, mostly PLLs, have an extra fixed divider just before
> the clock output. Add an option to the factor clk driver config data to
> specify this divider.
> 
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
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140911/cf136ac2/attachment.sig>
