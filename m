From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 08 Dec 2014 17:06:11 +0530
Subject: [PATCH 05/19] clk: samsung: exynos5433: Add clocks for CMU_G2D
 domain
In-Reply-To: <1417510196-6714-6-git-send-email-cw00.choi@samsung.com>
References: <1417510196-6714-1-git-send-email-cw00.choi@samsung.com>
 <1417510196-6714-6-git-send-email-cw00.choi@samsung.com>
Message-ID: <54858D2B.3040809@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chanwoo,

On Tuesday 02 December 2014 02:19 PM, Chanwoo Choi wrote:
> This patch adds ths mux/divider/gate clocksof CMU_G2D domain which includes

nit: %s/clocksof/clocks of

> G2D/MDMA IPs. The CMU_G2D must need the clocks related to G2D by providing
> CMU_TOP domain. So, this patch add several clocks for G2D from CMU_TOP domain.
>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Inki Dae <inki.dae@samsung.com>
> Acked-by: Geunsik Lim <geunsik.lim@samsung.com>
> ---
>   .../devicetree/bindings/clock/exynos5433-clock.txt |   8 ++
>   drivers/clk/samsung/clk-exynos5433.c               | 144 +++++++++++++++++++++
>   include/dt-bindings/clock/exynos5433.h             |  42 +++++-
>   3 files changed, 193 insertions(+), 1 deletion(-)
>

Verified all changes in clock file against UM I have with me, all 
changes are OK.

With small nit in commit message feel free to add:

Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>

Thanks,
Pankaj Dubey
