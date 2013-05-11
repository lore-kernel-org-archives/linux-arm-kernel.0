From: dianders@chromium.org (Doug Anderson)
Date: Sat, 11 May 2013 14:26:07 -0700
Subject: [PATCH 2/2] ARM: dts: Document DP clock in samsung,
 exynos5-dp binding
In-Reply-To: <003101ce4e1b$4acc0050$e06400f0$@samsung.com>
References: <003101ce4e1b$4acc0050$e06400f0$@samsung.com>
Message-ID: <CAD=FV=UjohPBxChbE2R4b8JWCbxZRXVx_9WuMYPgHTehMP6vvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jingoo,

On Sat, May 11, 2013 at 12:43 AM, Jingoo Han <jg1.han@samsung.com> wrote:
> The exynos5-dp node needs a clock specified using the common clock
> framework.
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
> Tested on Exynos5250
>
>  .../devicetree/bindings/video/exynos_dp.txt        |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)

Thanks for updating the bindings.  This looks good.

Reviewed-by: Doug Anderson <dianders@chromium.org>
