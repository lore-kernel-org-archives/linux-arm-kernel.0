From: robh@kernel.org (Rob Herring)
Date: Mon, 19 Feb 2018 08:36:20 -0600
Subject: [PATCH 1/5] dt-bindings: clock: ti: add latching support to mux
 and divider clocks
In-Reply-To: <1518698991-10099-2-git-send-email-t-kristo@ti.com>
References: <1518698991-10099-1-git-send-email-t-kristo@ti.com>
 <1518698991-10099-2-git-send-email-t-kristo@ti.com>
Message-ID: <20180219143620.vu3ucann7vmgsdlt@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 15, 2018 at 02:49:47PM +0200, Tero Kristo wrote:
> Certain hardware configurations, like dra76x, have some of the clock
> registers partitioned in a funky manner that requires the clock
> control setup to be latched for PRCM to be notified of the change. This
> is accomplished with a separate control bit under the register. Add
> support for this clock latching support to divider and mux clocks.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  Documentation/devicetree/bindings/clock/ti/divider.txt | 3 +++
>  Documentation/devicetree/bindings/clock/ti/mux.txt     | 3 +++
>  2 files changed, 6 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
