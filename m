From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 7 Oct 2016 10:55:28 +0200
Subject: [PATCH 4/9] drm/sun4i: Add compatible string for A31/A31s TCON
 (timing controller)
In-Reply-To: <20161006160629.11198-5-wens@csie.org>
References: <20161006160629.11198-1-wens@csie.org>
 <20161006160629.11198-5-wens@csie.org>
Message-ID: <20161007085528.GJ4684@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Oct 07, 2016 at 12:06:24AM +0800, Chen-Yu Tsai wrote:
> The A31 TCON has mux controls for how TCON outputs are routed to the
> HDMI and MIPI DSI blocks.
> 
> Since the A31s does not have MIPI DSI, it only has a mux for the HDMI
> controller input.
> 
> This patch only adds support for the compatible strings. Actual support
> for the mux controls should be added with HDMI and MIPI DSI support.

Then let's add those fields then, having dead code and useless
variables is never a good option :)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161007/265db26f/attachment-0001.sig>
