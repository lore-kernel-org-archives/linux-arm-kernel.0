From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 28 Jun 2018 09:53:36 +0800
Subject: [linux-sunxi] [PATCH v3 06/24] drm/sun4i: Fix releasing node when
 enumerating enpoints
In-Reply-To: <20180625120304.7543-7-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
 <20180625120304.7543-7-jernej.skrabec@siol.net>
Message-ID: <CAGb2v65dNvqcWa7MUMesrEeDGfEmd0xPpKQmbqJ60_FHe=Y_JA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2018 at 8:02 PM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> sun4i_drv_add_endpoints() has a memory leak since it uses of_node_put()
> when remote is equal to NULL and does nothing when remote has a valid
> pointer.
>
> Invert the logic to fix memory leak.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Given this is a fix, it should have Fixes and stable tags.

ChenYu
