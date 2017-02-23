From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 23 Feb 2017 10:20:19 -0800
Subject: [PATCH 02/11] drm/sun4i: Set drm_crtc.port to the underlying
 TCON's output port node
In-Reply-To: <20170223080543.6659-3-wens@csie.org>
References: <20170223080543.6659-1-wens@csie.org>
 <20170223080543.6659-3-wens@csie.org>
Message-ID: <20170223182019.rq4abaalet5bveq7@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2017 at 04:05:34PM +0800, Chen-Yu Tsai wrote:
> The way drm_of_find_possible_crtcs is it tries to match the

Aren't you missing "works" here     ^

> remote-endpoint of the given node's various endpoints to all the
> crtc's .port field. Thus we need to set drm_crtc.port to the output
> port node of the underlying TCON.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Added it, and applied.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170223/607990bf/attachment.sig>
