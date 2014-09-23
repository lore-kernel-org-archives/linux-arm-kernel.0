From: dianders@chromium.org (Doug Anderson)
Date: Tue, 23 Sep 2014 11:16:14 -0700
Subject: [PATCH v3 6/8] clk: rockchip: add new clock-type for the cpuclk
In-Reply-To: <CAJuA9agRa65eL=YTUJ=MOu2akO6i61Es0m3v8sPsTQ1NaK-L7Q@mail.gmail.com>
References: <1410991974-12235-1-git-send-email-heiko@sntech.de>
 <1410991974-12235-7-git-send-email-heiko@sntech.de>
 <CAD=FV=Xtd9F23vePiDOKbn8GMpS615qrs6FDCep_cdGNC=KP0w@mail.gmail.com>
 <2964934.WLjiJxGorQ@phil>
 <CAJuA9agRa65eL=YTUJ=MOu2akO6i61Es0m3v8sPsTQ1NaK-L7Q@mail.gmail.com>
Message-ID: <CAD=FV=Vj4WkiT7TPJORPS9k2atxu4oeim1JD4izKMD-4ZgvwkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On Mon, Sep 22, 2014 at 10:25 PM, Thomas Abraham <ta.omasab@gmail.com> wrote:
> In the samsung cpuclk implementation, the ratio between PLL output and
> armclk is always 1:1. So the divider that divides the PLL output to
> get the armclk clock is always set to zero (div by 1). That divider
> gets a non-zero value only when using an alternate parent clock source
> during rate change operations.

The dividers we're discussing here are extra dividers.  In exynos
speak this would be things like "CPUD", "ATB", "PCLK_DBG".

-Doug
