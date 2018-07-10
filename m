From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 10 Jul 2018 23:23:38 +0800
Subject: [PATCH 05/17] drm/sun4i: tcon: Release node when traversing of
 graph
In-Reply-To: <20180706175113.26698-6-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net>
 <20180706175113.26698-6-jernej.skrabec@siol.net>
Message-ID: <CAGb2v660yji16F_EyoezyZrAJaC9_MWF3giCfGXVcL3RJ6c5fw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 7, 2018 at 1:51 AM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> Function sun4i_tcon_find_engine_traverse() doesn't release node if it
> needs to traverse of graph deeper than 1 level.
>
> Fix this by calling of_node_put().
>
> Fixes: 49836b11fe71 ("drm/sun4i: tcon: Generalize engine search algorithm")
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
