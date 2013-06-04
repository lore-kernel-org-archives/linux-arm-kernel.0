From: dianders@chromium.org (Doug Anderson)
Date: Tue, 4 Jun 2013 10:09:24 -0700
Subject: [PATCH V5 2/5] clk: samsung: register audio subsystem clocks
 using common clock framework
In-Reply-To: <1370348890-6645-3-git-send-email-padma.v@samsung.com>
References: <1370348890-6645-1-git-send-email-padma.v@samsung.com>
 <1370348890-6645-3-git-send-email-padma.v@samsung.com>
Message-ID: <CAD=FV=X6FNsYDwrcd1ksF47F5MEq=9-=iX1ifP6S5vKRUVm=uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Padmavathi,

On Tue, Jun 4, 2013 at 5:28 AM, Padmavathi Venna <padma.v@samsung.com> wrote:
> Audio subsystem is introduced in s5pv210 and exynos platforms.
> This has seperate clock controller which can control i2s0 and
> pcm0 clocks. This patch registers the audio subsystem clocks
> with the common clock framework on Exynos family.
>
> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
> Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  .../devicetree/bindings/clock/clk-exynos-audss.txt |   64 ++++++++++
>  drivers/clk/samsung/Makefile                       |    1 +
>  drivers/clk/samsung/clk-exynos-audss.c             |  133 ++++++++++++++++++++
>  include/dt-bindings/clk/exynos-audss-clk.h         |   25 ++++
>  4 files changed, 223 insertions(+), 0 deletions(-)

Thanks for fixing up my nits.  This looks good to me.

Reviewed-by: Doug Anderson <dianders@chromium.org>
