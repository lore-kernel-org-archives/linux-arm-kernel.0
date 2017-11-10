From: robh@kernel.org (Rob Herring)
Date: Fri, 10 Nov 2017 15:11:54 -0600
Subject: [PATCH V4 09/12] clk: sprd: Add dt-bindings include file for
 SC9860
In-Reply-To: <20171110063607.3250-10-chunyan.zhang@spreadtrum.com>
References: <20171110063607.3250-1-chunyan.zhang@spreadtrum.com>
 <20171110063607.3250-10-chunyan.zhang@spreadtrum.com>
Message-ID: <20171110211154.z2j5emtcdef7xqv2@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 10, 2017 at 02:36:04PM +0800, Chunyan Zhang wrote:
> This file defines all SC9860 clock indexes, it should be included in the
> device tree in which there's device using the clocks.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
> ---
>  include/dt-bindings/clock/sprd,sc9860-clk.h | 408 ++++++++++++++++++++++++++++
>  1 file changed, 408 insertions(+)
>  create mode 100644 include/dt-bindings/clock/sprd,sc9860-clk.h

Acked-by: Rob Herring <robh@kernel.org>
