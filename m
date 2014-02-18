From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 18 Feb 2014 14:23:22 +0100
Subject: [PATCH RESEND v3] clk: return probe defer when DT clock not yet
 ready
In-Reply-To: <20140208132446.2A26694003E@smtp1-g21.free.fr>
References: <20140208132446.2A26694003E@smtp1-g21.free.fr>
Message-ID: <53035ECA.5080804@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/11/13 19:47, Jean-Francois Moine wrote:
> At probe time, a clock device may not be ready when some other device
> wants to use it.
> 
> This patch lets the functions clk_get/devm_clk_get return a probe defer
> when the clock is defined in the DT but not yet available.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Tested-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

Hope this can be merged for v3.15. Thanks.
