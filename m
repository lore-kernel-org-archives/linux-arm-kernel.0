From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Fri, 29 Jun 2018 21:19:33 +0200
Subject: [PATCH v3 16/24] drm/sun4i: Enable DW HDMI PHY clock
In-Reply-To: <CAGb2v65En4RbVdRu7c6MJUztVhC36dWr0kaO9bqc9PtuXAcsww@mail.gmail.com>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
 <20180625120304.7543-17-jernej.skrabec@siol.net>
 <CAGb2v65En4RbVdRu7c6MJUztVhC36dWr0kaO9bqc9PtuXAcsww@mail.gmail.com>
Message-ID: <3131254.YlICBQirlu@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?etrtek, 28. junij 2018 ob 04:22:36 CEST je Chen-Yu Tsai napisal(a):
> On Mon, Jun 25, 2018 at 8:02 PM, Jernej Skrabec <jernej.skrabec@siol.net> 
wrote:
> > Current DW HDMI PHY code never prepares and enables PHY clock after it is
> > created. It's just used as it is. This may work in some cases, but it's
> > clearly wrong. Fix it by adding proper calls to enable/disable PHY
> > clock.
> > 
> > Fixes: 4f86e81748fe ("drm/sun4i: Add support for H3 HDMI PHY variant")
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> 
> So why does it work on the H3? Because there's only one PLL that the whole
> display pipeline uses?
> 
> We should probably tag this for stable. So,
> 
> Cc: <stable@vger.kernel.org>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Same question as before, how this should be handled? Can I send separate patch 
with same content to stable ML only?

Best regards,
Jernej
