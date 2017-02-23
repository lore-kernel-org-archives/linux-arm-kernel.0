From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 23 Feb 2017 10:18:54 -0800
Subject: [PATCH 01/11] drm/sun4i: Make sunxi_rgb2yuv_coef constant
In-Reply-To: <20170223080543.6659-2-wens@csie.org>
References: <20170223080543.6659-1-wens@csie.org>
 <20170223080543.6659-2-wens@csie.org>
Message-ID: <20170223181854.xovajppgsqonmxnc@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2017 at 04:05:33PM +0800, Chen-Yu Tsai wrote:
> sunxi_rgb2yuv_coef is a table of RGB-to-YUV conversion coefficients.
> They are programmed into the hardware, and can be declared constant.
> 
> Reported-by: Priit Laes <plaes@plaes.org>
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170223/7378e1dc/attachment.sig>
