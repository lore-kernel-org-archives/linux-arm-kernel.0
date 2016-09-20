From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 20 Sep 2016 09:19:48 +0200
Subject: [PATCH 4/4] drm/sun4i: dotclock: Round to closest clock rate
In-Reply-To: <20160915151402.15992-5-wens@csie.org>
References: <20160915151402.15992-1-wens@csie.org>
 <20160915151402.15992-5-wens@csie.org>
Message-ID: <20160920071948.GB8719@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2016 at 11:14:02PM +0800, Chen-Yu Tsai wrote:
> With display pixel clocks we want to have the closest possible clock
> rate, to minimize timing and refresh rate skews. Whether the actual
> clock rate is higher or lower than the requested rate is less important.
> 
> Also check candidates against the requested rate, rather than the
> ideal parent rate, the varying dividers also influence the difference
> between the requested rate and the rounded rate.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160920/81bddca7/attachment.sig>
