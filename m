From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 21 Feb 2017 12:19:34 -0800
Subject: [PATCH 1/7] drm/sun4i: Move drm_mode_config_cleanup call to main
 driver
In-Reply-To: <20170217031330.14087-2-wens@csie.org>
References: <20170217031330.14087-1-wens@csie.org>
 <20170217031330.14087-2-wens@csie.org>
Message-ID: <20170221201934.nyel2kcta3pfcdbo@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2017 at 11:13:24AM +0800, Chen-Yu Tsai wrote:
> drm_mode_config_cleanup is the complement of drm_mode_config_init, which
> is called in the bind function of sun4i_drv. drm_mode_config_cleanup
> should be put in the unbind function to match.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170221/5c803faa/attachment.sig>
