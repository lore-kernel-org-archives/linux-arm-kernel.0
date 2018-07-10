From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 10 Jul 2018 23:56:27 +0800
Subject: [PATCH 10/17] drm/sun4i: tcon-top: Add helpers for switching mux
In-Reply-To: <20180706175113.26698-11-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net>
 <20180706175113.26698-11-jernej.skrabec@siol.net>
Message-ID: <CAGb2v65TTC_JmcrAvd0fYDuMs4H+MwvqrL+LUfGpp_zY+qsavQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 7, 2018 at 1:51 AM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> We want to be able to set TCON TOP muxes at runtime. Add helpers for
> that.
>
> Old, static configuration of muxes at probe time is preserved for now.
> It will be removed when R40 TCON starts using them.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
