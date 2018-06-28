From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 28 Jun 2018 10:42:01 +0800
Subject: [PATCH v3 22/24] drm/sun4i: DW HDMI: Expand algorithm for
 possible crtcs
In-Reply-To: <20180625120304.7543-23-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
 <20180625120304.7543-23-jernej.skrabec@siol.net>
Message-ID: <CAGb2v67DHtUDyPXKykz1LxehGZRJ2PzPC=1G7iW0hoMzD+6Juw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2018 at 8:03 PM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> drm_of_find_possible_crtcs() doesn't work when DW HDMI encoder is
> connected to TCON (crtc) through mux in TCON TOP.
>
> In that case TCON TOP HDMI mux input port has to be manually traversed
> and checked if it matches any known crtc.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
