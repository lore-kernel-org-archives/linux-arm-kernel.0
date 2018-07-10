From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 10 Jul 2018 23:23:14 +0800
Subject: [PATCH 04/17] drm/sun4i: tcon-top: Cleanup clock handling
In-Reply-To: <20180706175113.26698-5-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net>
 <20180706175113.26698-5-jernej.skrabec@siol.net>
Message-ID: <CAGb2v644vnkyG=zOLH43Ty7sprMTCnFTeXspgJv_=Z_rNvsg0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 7, 2018 at 1:51 AM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> There is no need to acquire reference to clock just to get its name.
>
> This commit just cleans up the code. There is no functional change.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
