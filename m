From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 19 Jan 2015 09:15:21 -0800
Subject: [GIT PULL] clk: more Exynos7 clock tree definitions
In-Reply-To: <54B95A44.50105@samsung.com>
References: <54B95A44.50105@samsung.com>
Message-ID: <20150119171521.22722.84999@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sylwester Nawrocki (2015-01-16 10:36:52)
> 
> Hi Mike,
> 
> Please find below a few clk updates for exynos7 SoC. I kept them on
> a separate branch as there will likely be depending dts patches.
> Please pull for 3.20.
> 
> The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:
> 
>   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)
> 
> are available in the git repository at:
> 
>   git://linuxtv.org/snawrocki/samsung.git tags/for-v3.20-exynos7-clk

Pulled.

Regards,
Mike

> 
> for you to fetch changes up to 9f930a39e135d370d17e7a1ab73ddebcfb896f98:
> 
>   clk: samsung: exynos7: add clocks for audio block (2015-01-15 15:18:51 +0100)
> 
> ----------------------------------------------------------------
> - Clock definitions for Exynos7 SoC peripheral devices:
>   video scaler, USB, DMA, SPI and the audio subsystem.
> 
> ----------------------------------------------------------------
> Padmavathi Venna (3):
>       clk: samsung: exynos7: add gate clock for DMA block
>       clk: samsung: exynos7: add clocks for SPI block
>       clk: samsung: exynos7: add clocks for audio block
> 
> Tony K Nadackal (1):
>       clk: samsung: exynos7: Add clocks for MSCL block
> 
> Vivek Gautam (1):
>       clk: samsung: exynos7: Add required clock tree for USB
> 
>  .../devicetree/bindings/clock/exynos7-clock.txt    |   15 +
>  drivers/clk/samsung/clk-exynos7.c                  |  408 +++++++++++++++++++-
>  include/dt-bindings/clock/exynos7-clk.h            |   88 ++++-
>  3 files changed, 505 insertions(+), 6 deletions(-)
> 
> Thanks,
> Sylwester
