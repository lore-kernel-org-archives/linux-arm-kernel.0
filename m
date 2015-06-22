From: dianders@chromium.org (Doug Anderson)
Date: Mon, 22 Jun 2015 12:59:19 -0700
Subject: [PATCH v2 2/2] ARM: rockchip: remove some useless macro in pm.h
In-Reply-To: <1434880847-29505-3-git-send-email-zyw@rock-chips.com>
References: <1434880847-29505-1-git-send-email-zyw@rock-chips.com>
 <1434880847-29505-3-git-send-email-zyw@rock-chips.com>
Message-ID: <CAD=FV=Xa_T-L+mU77gfo9Vau9Q4KcJ=RTYzHcbv05=4Xy8R-8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chris,

On Sun, Jun 21, 2015 at 3:00 AM, Chris Zhong <zyw@rock-chips.com> wrote:
> These are actually not used in the pm code, as we moved suspend handling
> to the clock driver, remove them here.
>
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
>
> ---
>
>  arch/arm/mach-rockchip/pm.h | 7 -------
>  1 file changed, 7 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
