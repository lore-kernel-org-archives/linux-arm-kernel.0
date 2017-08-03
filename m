From: robh@kernel.org (Rob Herring)
Date: Thu, 3 Aug 2017 11:31:57 -0500
Subject: [PATCH v3 1/5] dt-bindings: update the Allwinner GPADC device
 tree binding for H3
In-Reply-To: <20170723141354.42646-2-icenowy@aosc.io>
References: <20170723141354.42646-1-icenowy@aosc.io>
 <20170723141354.42646-2-icenowy@aosc.io>
Message-ID: <20170803163157.atqcerzehrihvvtb@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 23, 2017 at 10:13:50PM +0800, Icenowy Zheng wrote:
> Allwinner H3 features a thermal sensor like the one in A33, but has its
> register re-arranged, the clock divider moved to CCU (originally the
> clock divider is in ADC) and added a pair of bus clock and reset.
> 
> Update the binding document to cover H3.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes in v3:
> - Clock name changes.
> - Example node name changes.
> - Add interupts (not yet used by the driver).
> 
>  .../devicetree/bindings/mfd/sun4i-gpadc.txt        | 25 ++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
