From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 22 Sep 2018 21:29:06 +0800
Subject: [PATCH 16/27] drm/sun4i: dw-hdmi: Make mode_valid function
 configurable
In-Reply-To: <20180902072643.4917-17-jernej.skrabec@siol.net>
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
 <20180902072643.4917-17-jernej.skrabec@siol.net>
Message-ID: <CAGb2v64J7N+z1v2mXvB2hZuDEMZ2Zty-AG3L12r37NZvkk_n5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 2, 2018 at 3:27 PM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
>
> Since it is not possible to access sun8i-dw-hdmi driver private data
> inside mode_valid function, make it configurable. That way different
> versions of HDMI controllers can set different function, depending on
> it's limitations.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
