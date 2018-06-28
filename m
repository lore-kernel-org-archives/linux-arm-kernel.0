From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 28 Jun 2018 10:25:54 +0800
Subject: [PATCH v3 18/24] drm/sun4i: DW HDMI PHY: Add support for second
 PLL
In-Reply-To: <20180625120304.7543-19-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
 <20180625120304.7543-19-jernej.skrabec@siol.net>
Message-ID: <CAGb2v651RGegpAi-2efhBUkyFf1iC+zxOGTbRkmjuWcYSTgYJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2018 at 8:02 PM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> Some DW HDMI PHYs, like those found in A64 and R40 SoCs, can select
> between two clock parents.
>
> Add code which reads second PLL from DT.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

This patch by itself does not do anything. It should be merged with the
next one.
