From: dianders@chromium.org (Doug Anderson)
Date: Mon, 11 Mar 2013 10:36:42 -0700
Subject: [PATCH] spi: s3c64xx: let device core setup the default pin
 configuration
In-Reply-To: <1362570130-14084-1-git-send-email-thomas.abraham@linaro.org>
References: <1362570130-14084-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <CAD=FV=W++WXLOazKR=f6PHdzr=AVOwyT2i=swNtw6yMOJhJgmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On Wed, Mar 6, 2013 at 3:42 AM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:
> With device core now able to setup the default pin configuration,
> the pin configuration code based on the deprecated Samsung specific
> gpio bindings is removed.
>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  .../devicetree/bindings/spi/spi-samsung.txt        |    8 +--
>  drivers/spi/spi-s3c64xx.c                          |   66 +------------------
>  2 files changed, 6 insertions(+), 68 deletions(-)

With <https://patchwork.kernel.org/patch/2225151/> on exynos5250-snow
(ARM Chromebook):

Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>

-Doug
