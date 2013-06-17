From: dianders@chromium.org (Doug Anderson)
Date: Mon, 17 Jun 2013 07:55:46 -0700
Subject: [PATCH V2] ARM: dts: Enable RTC node for Arndale
In-Reply-To: <1371442179-23597-1-git-send-email-tushar.behera@linaro.org>
References: <CAHbNUh2byimQ_ep0j9XkUjRFaU3K6YZE_ANcch5UhP4QsuZxPw@mail.gmail.com>
 <1371442179-23597-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <CAD=FV=XAeLQ8DfcskRRE_h1AKu-CPA3jEGwNThJOmKm6LEiegQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tushar,

On Sun, Jun 16, 2013 at 9:09 PM, Tushar Behera <tushar.behera@linaro.org> wrote:
> The issues reported in commit 522ccdb6fd0e ("ARM: dts: Disable the RTC
> by default on exynos5") are no longer reproduced on EXYNOS5250 based
> Arndale board. Hence re-enabling RTC support for Arndale board.
>
> This is helpful for testing S2R on Arndale board.
>
> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
> ---
> Changes for V2:
> * RTC node is enabled only for Arndale board. Earlier it was enabled
> in exynos5250.dtsi.
>
>  arch/arm/boot/dts/exynos5250-arndale.dts |    4 ++++
>  1 file changed, 4 insertions(+)

Looks good!  I'll send up one for snow too.

Reviewed-by: Doug Anderson <dianders@chromium.org>
