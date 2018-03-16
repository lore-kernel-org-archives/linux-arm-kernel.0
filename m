From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 16 Mar 2018 13:36:58 -0700
Subject: [PATCH v3 01/15] dt-bindings: clock: mediatek: add missing
 required #reset-cells
In-Reply-To: <7365f2286ff2cebcfb590715cb4a15dedd089046.1518895232.git.sean.wang@mediatek.com>
References: <cover.1518895232.git.sean.wang@mediatek.com>
 <7365f2286ff2cebcfb590715cb4a15dedd089046.1518895232.git.sean.wang@mediatek.com>
Message-ID: <152123261872.225550.10226809804986023416@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting sean.wang at mediatek.com (2018-02-17 11:54:36)
> From: Sean Wang <sean.wang@mediatek.com>
> 
> All ethsys, pciesys and ssusbsys internally include reset controller, so
> explicitly add back these missing cell definitions to related bindings
> and examples.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: linux-clk at vger.kernel.org
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
