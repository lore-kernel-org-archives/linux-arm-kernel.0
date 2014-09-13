From: dianders@chromium.org (Doug Anderson)
Date: Fri, 12 Sep 2014 17:10:46 -0700
Subject: [PATCH v2 6/7] clk: rockchip: add binding id for ARMCLK
In-Reply-To: <1410561030-19127-7-git-send-email-heiko@sntech.de>
References: <1410561030-19127-1-git-send-email-heiko@sntech.de>
 <1410561030-19127-7-git-send-email-heiko@sntech.de>
Message-ID: <CAD=FV=XWG1+PktkJUjSMaswRnJ-d6WVcf5AnVyKPp1=c4vn1eQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Fri, Sep 12, 2014 at 3:30 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  include/dt-bindings/clock/rk3188-cru-common.h | 1 +
>  include/dt-bindings/clock/rk3288-cru.h        | 1 +
>  2 files changed, 2 insertions(+)

A little silly to say that I tested adding #defines, but it does
compile and later patches work...

Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>
