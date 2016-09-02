From: dianders@chromium.org (Doug Anderson)
Date: Thu, 1 Sep 2016 20:54:00 -0700
Subject: [PATCH v5 4/4] nvmem: rockchip-efuse: add rk3399-efuse support
In-Reply-To: <1472786217-52214-5-git-send-email-finley.xiao@rock-chips.com>
References: <1472786217-52214-1-git-send-email-finley.xiao@rock-chips.com>
 <1472786217-52214-5-git-send-email-finley.xiao@rock-chips.com>
Message-ID: <CAD=FV=VUy5hEZBT6ehpTS=5-moOJsSTqEM6tJeahZ-MeGz_5fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 1, 2016 at 8:16 PM, Finley Xiao <finley.xiao@rock-chips.com> wrote:
> 1) the efuse timing of rk3399 is different from earlier SoCs.
> 2) rk3399-efuse is organized as 32bits by 32 one-time programmable
> electrical fuses, the efuse of earlier SoCs is organized as 32bits
> by 8 one-time programmable electrical fuses with random access interface.
>
> This patch adds a new read function for rk3399-efuse.
>
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/nvmem/rockchip-efuse.c | 133 +++++++++++++++++++++++++++++++++++------
>  1 file changed, 114 insertions(+), 19 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
