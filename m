From: dianders@chromium.org (Doug Anderson)
Date: Wed, 5 Aug 2015 16:45:50 -0700
Subject: [PATCH v3 1/3] ARM: rockchip: rename osc_switch_to_32k variable
In-Reply-To: <2128609.Kb18M8K28F@diego>
References: <2128609.Kb18M8K28F@diego>
Message-ID: <CAD=FV=V57vrP-6pzRf5+5FwvHnm0OL9ztyHoeQKOASzz8pPrPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Tue, Aug 4, 2015 at 3:50 PM, Heiko St?bner <heiko@sntech.de> wrote:
> The variable name is misleading, as the deep suspend mode always switches
> the main supplying clock to the 32kHz source. Additionally the main
> oscillator remain running in some cases, which this var indicates.
>
> So rename it to osc_disable to clarity.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/arm/mach-rockchip/pm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
