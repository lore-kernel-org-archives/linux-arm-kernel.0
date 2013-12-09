From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 09 Dec 2013 17:34:44 +0100
Subject: [PATCH v4 2/4] clk: exynos5410: register clocks using common clock
 framework
In-Reply-To: <1385456288-20398-3-git-send-email-v.tyrtov@samsung.com>
References: <1385456288-20398-1-git-send-email-v.tyrtov@samsung.com>
 <1385456288-20398-3-git-send-email-v.tyrtov@samsung.com>
Message-ID: <1914850.6CAa0SzDWP@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vyacheslav, Tarek,

On Tuesday 26 of November 2013 12:58:06 Vyacheslav Tyrtov wrote:
> From: Tarek Dakhran <t.dakhran@samsung.com>
> 
> The EXYNOS5410 clocks are statically listed and registered
> using the Samsung specific common clock helper functions.
> 
> Signed-off-by: Tarek Dakhran <t.dakhran@samsung.com>
> Signed-off-by: Vyacheslav Tyrtov <v.tyrtov@samsung.com>
> ---
>  .../devicetree/bindings/clock/exynos5410-clock.txt |  54 +++++
>  drivers/clk/samsung/Makefile                       |   1 +
>  drivers/clk/samsung/clk-exynos5410.c               | 239 +++++++++++++++++++++
>  include/dt-bindings/clock/exynos5410.h             |  32 +++
>  4 files changed, 326 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/exynos5410-clock.txt
>  create mode 100644 drivers/clk/samsung/clk-exynos5410.c
>  create mode 100644 include/dt-bindings/clock/exynos5410.h

Acked-by: Tomasz Figa <t.figa@samsung.com>

This should go through Samsung tree, I guess, since it's a dependency
of other patches in this series and doesn't depend on any things from
clock tree. Mike, Kukjin, are you okay with this?

Best regards,
Tomasz
