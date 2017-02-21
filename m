From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 21 Feb 2017 14:13:18 -0800
Subject: [PATCH 7/7] drm/sun4i: Make sun4i_crtc_init return ERR_PTR style
 error codes
In-Reply-To: <20170217031330.14087-8-wens@csie.org>
References: <20170217031330.14087-1-wens@csie.org>
 <20170217031330.14087-8-wens@csie.org>
Message-ID: <20170221221318.utxhhfmrpftn27ae@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2017 at 11:13:30AM +0800, Chen-Yu Tsai wrote:
> sun4i_crtc_init can fail for a number of reasons. Instead of returning
> a NULL pointer when it fails, pass back the encountered error using
> ERR_PTR.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170221/a65a90e5/attachment-0001.sig>
