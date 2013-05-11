From: dianders@chromium.org (Doug Anderson)
Date: Sat, 11 May 2013 14:25:15 -0700
Subject: [PATCH 1/2] ARM: dts: add DP clock reference to exynos5250 device
 tree
In-Reply-To: <003001ce4e1b$24a28fc0$6de7af40$@samsung.com>
References: <003001ce4e1b$24a28fc0$6de7af40$@samsung.com>
Message-ID: <CAD=FV=V=exRoo1VAF5W7May_DFOWb6h_KL7BkqK3G2qmBQgUeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jingoo,

On Sat, May 11, 2013 at 12:42 AM, Jingoo Han <jg1.han@samsung.com> wrote:
> The transition to common clock happened; however, DP (Display Port)
> clock node was not added. Thus, DP (Display Port) clock node should
> be added to the device tree.
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
> Tested on Exynos5250
>
>  arch/arm/boot/dts/exynos5250.dtsi |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

Clock number matches clock bindings for 5250 and clock name matches dp
driver, so this looks good.

Reviewed-by: Doug Anderson <dianders@chromium.org>
