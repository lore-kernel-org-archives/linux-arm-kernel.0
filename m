From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 26 Apr 2017 08:21:26 +0200
Subject: [PATCH 0/3] drm/sun4i: More cleanups and fixes
In-Reply-To: <20170425152505.6796-1-wens@csie.org>
References: <20170425152505.6796-1-wens@csie.org>
Message-ID: <20170426062126.e2g6sqr42ytqfg3g@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 25, 2017 at 11:25:02PM +0800, Chen-Yu Tsai wrote:
> Hi Maxime,
> 
> The subject is probably getting old. Here are a few more cleanups.
> 
> Patch 1 should have been part of the patch
> 
>     drm/sun4i: Use lists to track registered display backends and TCONs
> 
> from my multiple pipeline support series. Please squash it in if you can.
> 
> Patch 2 just moves setting the TCON clocks back inside the TCON driver.
> 
> Patch 3 cleans up a DRM driver debug message.

Applied all, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170426/c32dc853/attachment.sig>
