From: dianders@chromium.org (Doug Anderson)
Date: Mon, 2 Oct 2017 08:14:50 -0700
Subject: [PATCH] ASoC: rockchip: Fix wrong allocation size of dapm routes
In-Reply-To: <20170929035252.19808-1-jeffy.chen@rock-chips.com>
References: <20170929035252.19808-1-jeffy.chen@rock-chips.com>
Message-ID: <CAD=FV=V+sVf8E_ka1u5kDBKWS6MY3vMpaVgmjDV1CnVSOkQ3AA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 28, 2017 at 8:52 PM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
> The allocation size of dapm routes is wrong, correct it.
>
> Fixes: d9f9c167edae ("ASoC: rockchip: Init dapm routes dynamically")
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
>
>  sound/soc/rockchip/rk3399_gru_sound.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

I guess Jeffy and I found this independently.  In
http://crosreview.com/693319 Jeffy indicated that he thought my patch
could land, so I guess drop his and take mine from
<https://patchwork.kernel.org/patch/9978763/>?

Thanks!

-Doug
