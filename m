From: narmstrong@baylibre.com (Neil Armstrong)
Date: Sat, 03 Sep 2016 15:02:56 +0200
Subject: [PATCH] clk: meson-gxbb: Export PWM related clocks for DT
In-Reply-To: <1471870177-10609-1-git-send-email-narmstrong@baylibre.com>
References: <1471870177-10609-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <57CACA00.9010306@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Le 22/08/2016 14:49, Neil Armstrong a ?crit :
> Add the PWM related clocks in order to be referenced as PWM source
> clocks.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/clk/meson/gxbb.h              | 6 +++---
>  include/dt-bindings/clock/gxbb-clkc.h | 3 +++
>  2 files changed, 6 insertions(+), 3 deletions(-)

Dear Clock Maintainers,

Could you review this patch since it is a strong requirement to select the PWM clock parents over DT ?

Thanks,
Neil
