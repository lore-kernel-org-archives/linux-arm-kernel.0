From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 07 Feb 2014 12:41:56 +0100
Subject: [PATCH v2 2/9] clk: samsung: Provide common helpers for register
 save/restore
In-Reply-To: <1391710616-14226-3-git-send-email-t.figa@samsung.com>
References: <1391710616-14226-1-git-send-email-t.figa@samsung.com>
 <1391710616-14226-3-git-send-email-t.figa@samsung.com>
Message-ID: <52F4C684.20108@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/02/14 19:16, Tomasz Figa wrote:
> As suspend/resume handlers are being moved to SoC specific code, due to
> differencies in suspend/resume handling of particular SoCs, to minimize
> code duplication this patch provides common register save/restore
> helpers that save/restore given list of registers of clock controller.
> 
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
