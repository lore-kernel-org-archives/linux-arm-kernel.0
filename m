From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 18 Sep 2016 21:12:05 +0200
Subject: [PATCH 1/4] drm/sun4i: rgb: Declare RGB encoder and connector as
 MIPI DPI
In-Reply-To: <20160915151402.15992-2-wens@csie.org>
References: <20160915151402.15992-1-wens@csie.org>
 <20160915151402.15992-2-wens@csie.org>
Message-ID: <20160918191205.GG17518@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 15, 2016 at 11:13:59PM +0800, Chen-Yu Tsai wrote:
> The 18 or 24 bit parallel RGB LCD panel interface found on Allwinner
> SoCs matches the description of MIPI DPI. Declare the RGB encoder and
> connector as MIPI DPI.

Unfortunately, even it that patch might be true (is there a public
spec for that standard?), this breaks the user-space, so there's no
way we change this.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160918/808e0518/attachment.sig>
