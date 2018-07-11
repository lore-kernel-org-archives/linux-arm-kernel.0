From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 11 Jul 2018 10:55:26 +0800
Subject: [PATCH v2 08/18] ARM: dts: sun8i: r40: Add mixer ids to TCON TOP
In-Reply-To: <20180710203511.18454-9-jernej.skrabec@siol.net>
References: <20180710203511.18454-1-jernej.skrabec@siol.net>
 <20180710203511.18454-9-jernej.skrabec@siol.net>
Message-ID: <CAGb2v64N__6BctU5cxUHUxGtnc14ps18VrWfMC=kykOn8C+fKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 4:35 AM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> sun4i-drm DT binding, second paragraph of the first section says:
>
> For all connections between components up to the TCONs in the display
> pipeline, when there are multiple components of the same type at the
> same depth, the local endpoint ID must be the same as the remote
> component's index.
>
> Add mixer ids in R40 DT as mandated by DT binding.
>
> Fixes: 05a43a262d03 ("ARM: dts: sun8i: r40: Add HDMI pipeline")
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
