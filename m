From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 08 Dec 2014 17:01:02 +0530
Subject: [PATCH 02/19] clk: samsung: exynos5433: Add MUX clocks of CMU_TOP
 domain
In-Reply-To: <1417510196-6714-3-git-send-email-cw00.choi@samsung.com>
References: <1417510196-6714-1-git-send-email-cw00.choi@samsung.com>
 <1417510196-6714-3-git-send-email-cw00.choi@samsung.com>
Message-ID: <54858BF6.4040407@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chanwoo,

On Tuesday 02 December 2014 02:19 PM, Chanwoo Choi wrote:
> This patch adds the MUX (multiplexer) clocks for CMU_TOP domain of Exynos5433.
> CMU_TOP domain provides source clocks to other CMU domains.
>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Inki Dae <inki.dae@samsung.com>
> Acked-by: Geunsik Lim <geunsik.lim@samsung.com>
> ---

Reviewed all registers and clock relationships w.r.t UM I have and all 
changes are OK. So

Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>

Thanks,
Pankaj Dubey
