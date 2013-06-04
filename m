From: dianders@chromium.org (Doug Anderson)
Date: Tue, 4 Jun 2013 10:12:36 -0700
Subject: [PATCH V5 4/5] ARM: dts: add clock provider information for i2s
 controllers in Exynos5250
In-Reply-To: <1370348890-6645-5-git-send-email-padma.v@samsung.com>
References: <1370348890-6645-1-git-send-email-padma.v@samsung.com>
 <1370348890-6645-5-git-send-email-padma.v@samsung.com>
Message-ID: <CAD=FV=X6u51rYuBOT+EGBdKptgCSM-6PvW9L9Xgbiih9wOH+3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Padmavathi,

On Tue, Jun 4, 2013 at 5:28 AM, Padmavathi Venna <padma.v@samsung.com> wrote:
> Add clock lookup information for i2s controllers on exynos5250 SoC.
>
> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
> Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5250.dtsi |   10 ++++++++++

Would still like to see a separate patch documenting these clocks in
"Documentation/devicetree/bindings/sound/samsung-i2s.txt".  ...but
what's here looks good, thanks!

Reviewed-by: Doug Anderson <dianders@chromium.org>
