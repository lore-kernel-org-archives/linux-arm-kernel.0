From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 22 Sep 2018 21:30:52 +0800
Subject: [PATCH 17/27] drm/sun4i: dw-hdmi: Add quirk for setting TMDS clock
In-Reply-To: <20180902072643.4917-18-jernej.skrabec@siol.net>
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
 <20180902072643.4917-18-jernej.skrabec@siol.net>
Message-ID: <CAGb2v66oMoXxYCrnZpWMk_wtZMfqGonWM+fdc1BG-3NghcE7bQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 2, 2018 at 3:27 PM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
>
> It turns out that H6 HDMI BSP kernel driver doesn't change TMDS rate at
> all. At this point it is not clear whether it is just not necessary or
> it would cause some kind of issues.
>
> Add a quirk for it.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
