From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 28 Jun 2018 10:24:02 +0800
Subject: [PATCH v3 17/24] drm/sun4i: Don't change clock bits in DW HDMI
 PHY driver
In-Reply-To: <20180625120304.7543-18-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
 <20180625120304.7543-18-jernej.skrabec@siol.net>
Message-ID: <CAGb2v66Ew7bshwiObQsbep9CCNeVeQFzunYrDcQsw+F+7rffHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2018 at 8:02 PM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> DW HDMI PHY driver and PHY clock driver share same registers. Make sure
> that DW HDMI PHY setup code doesn't change any clock related bits.
> During initialization, set PHY PLL parent bit to 0.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

and maybe a fixes tag?
