From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Oct 2016 17:59:41 +0200
Subject: [PATCH v2 4/8] drm/sun4i: Add compatible string for A31/A31s
 TCON (timing controller)
In-Reply-To: <20161020034344.14154-5-wens@csie.org>
References: <20161020034344.14154-1-wens@csie.org>
 <20161020034344.14154-5-wens@csie.org>
Message-ID: <20161020155941.n2f34kamxkei3n5t@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2016 at 11:43:40AM +0800, Chen-Yu Tsai wrote:
> The A31 TCON has mux controls for how TCON outputs are routed to the
> HDMI and MIPI DSI blocks.
> 
> Since the A31s does not have MIPI DSI, it only has a mux for the HDMI
> controller input.
> 
> This patch only adds support for the compatible strings. Actual support
> for the mux controls should be added with HDMI and MIPI DSI support.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161020/ed0e53ae/attachment.sig>
