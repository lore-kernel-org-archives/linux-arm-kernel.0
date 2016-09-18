From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 18 Sep 2016 21:14:08 +0200
Subject: [PATCH 2/4] drm/sun4i: dotclock: Fix clock rate read back
 calcation
In-Reply-To: <20160915151402.15992-3-wens@csie.org>
References: <20160915151402.15992-1-wens@csie.org>
 <20160915151402.15992-3-wens@csie.org>
Message-ID: <20160918191408.GI17518@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2016 at 11:14:00PM +0800, Chen-Yu Tsai wrote:
> When reading back the divider set in the register, we mask off the
> bits that aren't part of the divider. Unfortunately the mask used
> here was not converted from the field width.
> 
> Fix this by converting the field width to a proper bit mask.
> 
> Fixes: 9026e0d122ac ("drm: Add Allwinner A10 Display Engine support")
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160918/2de11cb7/attachment-0001.sig>
