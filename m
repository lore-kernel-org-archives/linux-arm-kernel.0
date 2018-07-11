From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 11 Jul 2018 21:55:31 +0800
Subject: [linux-sunxi] [PATCH v3] drm/sun4i: mixer: Read id from DT
In-Reply-To: <20180711112706.30222-1-jernej.skrabec@siol.net>
References: <20180711112706.30222-1-jernej.skrabec@siol.net>
Message-ID: <CAGb2v67ShNTqYAKXRWwhKxzcyVw512bVmNrr-Kv-oDdVq+=yEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 7:27 PM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> Currently, TCON supports 2 ways to match TCON with engine (mixer in this
> case). Old way is to just traverse of graph backwards and compare node
> pointer. New way is to match TCON and engine by their respective ids.
> All SoCs with DE2 enabled till now used the old way, which means mixer
> id was never used and thus never implemented.
>
> However, for R40, only the new way will be used. To prepare for that,
> implement mixer id fetching from DT.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
