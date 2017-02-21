From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 21 Feb 2017 14:11:23 -0800
Subject: [PATCH 3/7] drm/sun4i: Check return value of drm_vblank_init
In-Reply-To: <20170217031330.14087-4-wens@csie.org>
References: <20170217031330.14087-1-wens@csie.org>
 <20170217031330.14087-4-wens@csie.org>
Message-ID: <20170221221123.7nyx6sg5q7pho3tj@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2017 at 11:13:26AM +0800, Chen-Yu Tsai wrote:
> drm_vblank_init can fail due to insufficient memory. Ignoring the error
> and proceeding may cause the kernel to dereference an invalid pointer
> when vblank is enabled.
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
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170221/ad307db9/attachment-0001.sig>
