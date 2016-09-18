From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 18 Sep 2016 21:13:47 +0200
Subject: [PATCH 3/4] drm/sun4i: dotclock: Allow divider = 127
In-Reply-To: <20160915151402.15992-4-wens@csie.org>
References: <20160915151402.15992-1-wens@csie.org>
 <20160915151402.15992-4-wens@csie.org>
Message-ID: <20160918191347.GH17518@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2016 at 11:14:01PM +0800, Chen-Yu Tsai wrote:
> The dot clock divider is 7 bits wide, and the divider range is 1 ~ 127,
> or 6 ~ 127 if phase offsets are used. The 0 register value also
> represents a divider of 1 or bypass.
> 
> Make the end condition of the for loop inclusive of 127 in the
> round_rate callback.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160918/34bb122f/attachment.sig>
