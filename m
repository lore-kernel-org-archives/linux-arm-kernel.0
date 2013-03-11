From: dianders@google.com (Doug Anderson)
Date: Mon, 11 Mar 2013 10:53:19 -0700
Subject: [PATCH] mmc: dwmmc: let device core setup the default pin
 configuration
In-Reply-To: <1362571461-14570-1-git-send-email-thomas.abraham@linaro.org>
References: <1362571461-14570-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <CAD=FV=W8E=0C8_QZ3d44caq6EOvBpTkX0Ng86niQuN4B-cnHiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On Wed, Mar 6, 2013 at 4:04 AM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:
> With device core now able to setup the default pin configuration,
> the pin configuration code based on the deprecated Samsung specific
> gpio bindings is removed.
>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  drivers/mmc/host/dw_mmc-exynos.c |   38 --------------------------------------
>  1 files changed, 0 insertions(+), 38 deletions(-)

It would be good to address Seungwon Jeon's comments (change prefix to
dw_mmc and remove setup_bus), but in general this looks good to me,
so...

With <https://patchwork.kernel.org/patch/2225151/> on exynos5250-snow
(ARM Chromebook):

Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>


-Doug
