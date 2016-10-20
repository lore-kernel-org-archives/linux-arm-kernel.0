From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Oct 2016 18:00:07 +0200
Subject: [PATCH v2 5/8] drm/sun4i: Add compatible strings for A31/A31s
 display pipelines
In-Reply-To: <20161020034344.14154-6-wens@csie.org>
References: <20161020034344.14154-1-wens@csie.org>
 <20161020034344.14154-6-wens@csie.org>
Message-ID: <20161020160007.hbdzhw53gcrl3hvj@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2016 at 11:43:41AM +0800, Chen-Yu Tsai wrote:
> The A31's display pipeline has 2 frontends, 2 backends, and 2 TCONs. It
> also has new display enhancement blocks, such as the DRC (Dynamic Range
> Controller), the DEU (Display Enhancement Unit), and the CMU (Color
> Management Unit). It supports HDMI, MIPI DSI, and 2 LCD/LVDS channels.
> 
> The A31s display pipeline is almost the same, just without MIPI DSI.
> Only the TCON seems to be different, due to the missing mux for MIPI
> DSI.
> 
> Add compatible strings for both of them.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Acked-by: Rob Herring <robh@kernel.org>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161020/704f2edd/attachment-0001.sig>
