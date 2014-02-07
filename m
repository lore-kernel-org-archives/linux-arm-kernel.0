From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 07 Feb 2014 12:32:48 +0100
Subject: [PATCH v2 1/9] clk: exynos4: Remove remnants of non-DT support
In-Reply-To: <1391710616-14226-2-git-send-email-t.figa@samsung.com>
References: <1391710616-14226-1-git-send-email-t.figa@samsung.com>
 <1391710616-14226-2-git-send-email-t.figa@samsung.com>
Message-ID: <52F4C460.1050306@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/02/14 19:16, Tomasz Figa wrote:
> This patch simplifies a bit clock initialization code by removing
> remnants of non-DT clock initialization, such as reg_base and xom values
> passed in function parameters.
> 
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
