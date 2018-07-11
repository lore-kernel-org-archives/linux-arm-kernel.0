From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 11 Jul 2018 11:15:29 +0800
Subject: [PATCH v2 17/18] drm/sun4i: tcon-top: Remove mux configuration at
 probe time
In-Reply-To: <20180710203511.18454-18-jernej.skrabec@siol.net>
References: <20180710203511.18454-1-jernej.skrabec@siol.net>
 <20180710203511.18454-18-jernej.skrabec@siol.net>
Message-ID: <CAGb2v66nDZqN86Rxr3CoUXkeeiSD2DdF7diuxo9rJEK6ypOsWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 4:35 AM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> Now that R40 TCON migrated to runtime mux configuration, old code can be
> removed.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
