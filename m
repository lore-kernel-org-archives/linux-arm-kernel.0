From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 12 Sep 2018 20:25:44 +0800
Subject: [PATCH 15/27] drm/sun4i: Not all DW HDMI controllers has
 scrambled addresses
In-Reply-To: <20180902072643.4917-16-jernej.skrabec@siol.net>
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
 <20180902072643.4917-16-jernej.skrabec@siol.net>
Message-ID: <CAGb2v66qrZG=RH9SYs7ZeZdhfcq+4sT47Y1dDQaeS1QBcEZXvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 2, 2018 at 3:27 PM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
>
> Currently supported Allwinner SoCs with DW HDMI controller have
> scrambled addresses and read lock. However, that is not true in general.
> For example, A80 and H6 have normal addresses and normal read access.
>
> Move code for unscrambling addresses and unlocking read access to it's
> own function and call it from init function.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
