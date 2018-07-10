From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 11 Jul 2018 00:14:40 +0800
Subject: [PATCH 12/17] drm/sun4i: tcon: Add support for R40 TCON
In-Reply-To: <20180706175113.26698-13-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net>
 <20180706175113.26698-13-jernej.skrabec@siol.net>
Message-ID: <CAGb2v67neknTdGyKLu=bMyXw7_M9Ji2GnVmqK1d20VWUsq2ROQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 7, 2018 at 1:51 AM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> R40 TV TCON is basically the same as on A83T. However, it needs special
> handling, because it has to set up TCON TOP muxes at runtime.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

The runtime muxing of mixer <-> TCON is quite clever.
