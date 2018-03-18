From: robh@kernel.org (Rob Herring)
Date: Sun, 18 Mar 2018 07:52:57 -0500
Subject: [PATCH v4 6/9] dt-bindings: add device tree binding for
 Allwinner H6 main CCU
In-Reply-To: <20180316140215.28663-7-icenowy@aosc.io>
References: <20180316140215.28663-1-icenowy@aosc.io>
 <20180316140215.28663-7-icenowy@aosc.io>
Message-ID: <20180318033523.kxtlewiwtboebtqe@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2018 at 10:02:12PM +0800, Icenowy Zheng wrote:
> The Allwinner H6 main CCU uses the internal oscillator of the SoC, which
> is different with old SoCs' main CCU.
> 
> Add device tree binding for the Allwinner H6 main CCU.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Extracted in v4.
> 
>  Documentation/devicetree/bindings/clock/sunxi-ccu.txt | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
