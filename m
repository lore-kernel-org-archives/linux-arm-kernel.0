From: dianders@chromium.org (Doug Anderson)
Date: Mon, 11 Aug 2014 09:19:18 -0700
Subject: [PATCH 2/4] ARM: rockchip: enable the AMBA bus
In-Reply-To: <1406661128-7614-3-git-send-email-heiko@sntech.de>
References: <1406661128-7614-1-git-send-email-heiko@sntech.de>
 <1406661128-7614-3-git-send-email-heiko@sntech.de>
Message-ID: <CAD=FV=V2qAd0MAAZubr-rUgA+DDLk-G0RLOvvME2=ym4vO-2-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Tue, Jul 29, 2014 at 12:12 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> This is needed to access the pl330 dma controllers on Rockchip SoCs.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/arm/mach-rockchip/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Doug Anderson <dianders@chromium.org>
