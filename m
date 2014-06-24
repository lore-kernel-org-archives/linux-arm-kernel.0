From: dianders@google.com (Doug Anderson)
Date: Tue, 24 Jun 2014 16:00:38 -0700
Subject: [PATCH 2/3] ARM: dts: Update the parent for Audss clocks in
 Exynos5420
In-Reply-To: <1402464739-19044-3-git-send-email-tushar.b@samsung.com>
References: <1402464739-19044-1-git-send-email-tushar.b@samsung.com>
 <1402464739-19044-3-git-send-email-tushar.b@samsung.com>
Message-ID: <CAD=FV=W5yh58fYTwRZxmZt=BORcZMSRV0oRe12yA74Q5h2S4YQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tushar,

On Tue, Jun 10, 2014 at 10:32 PM, Tushar Behera <tushar.b@samsung.com> wrote:
> Currently CLK_FOUT_EPLL was set as one of the parents of AUDSS mux.
> As per the user manual, it should be CLK_MAU_EPLL.
>
> The problem surfaced when the bootloader in Peach-pit board set
> the EPLL clock as the parent of AUDSS mux. While booting the kernel,
> we used to get a system hang during late boot if CLK_MAU_EPLL was
> disabled.
>
> Signed-off-by: Tushar Behera <tushar.b@samsung.com>
> Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
> Reported-by: Kevin Hilman <khilman@linaro.org>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I've tested this myself now as well.

Tested-by: Doug Anderson <dianders@chromium.org>
