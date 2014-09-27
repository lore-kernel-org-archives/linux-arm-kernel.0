From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 27 Sep 2014 09:10:07 +0200
Subject: [PATCH v3 0/2] clk: sun8i: Add MBUS support
In-Reply-To: <1410861842-2743-1-git-send-email-wens@csie.org>
References: <1410861842-2743-1-git-send-email-wens@csie.org>
Message-ID: <20140927071007.GZ15315@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

On Tue, Sep 16, 2014 at 06:04:00PM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> This is v3 of my sun8i MBUS clock series.
> 
> This series depends on Maxime's "clk: sunxi: Improve MMC clocks support"
> series, specifically the patches that change the factor clocks and move
> out mod0 and mbus. Ideally this series should also be merged after my
> "clk: sun6i: Unify AHB1 clock and fix rate calculation" for the PLL6
> corrections, but I don't think it would cause any issues if it didn't.

I'll hold off the second patch, since we're still in discussion for
the PLL6 part. And since we're very close to the merge window opening,
it would have been merged for 3.19 anyway, and we still have plenty of
time.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140927/a4f6d458/attachment-0001.sig>
