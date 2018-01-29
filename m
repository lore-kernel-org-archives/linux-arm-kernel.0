From: robh@kernel.org (Rob Herring)
Date: Mon, 29 Jan 2018 13:59:21 -0600
Subject: [PATCH v6 17/41] dt-bindings: clock: Add bindings for DA8XX
 CFGCHIP clocks
In-Reply-To: <1516468460-4908-18-git-send-email-david@lechnology.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-18-git-send-email-david@lechnology.com>
Message-ID: <20180129195921.q7wqqawgwsbqgf7t@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 20, 2018 at 11:13:56AM -0600, David Lechner wrote:
> This adds a new binding for the clocks present in the CFGCHIP syscon
> registers in TI DA8XX SoCs.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
> 
> v6 changes:
> - combine "dt-bindings: clock: Add bindings for DA8XX CFGCHIP gate clocks",
>   "dt-bindings: clock: Add binding for TI DA8XX CFGCHIP mux clocks" and
>   "dt-bindings: clock: Add bindings for TI DA8XX USB PHY clocks" into a single
>   file containing all CFGCHIP clocks bindings
> - added compatible = "ti,da830-div4p5ena"
> - added compatible = "ti,da850-async1-clksrc"
> - renamed other compatible strings
> - changed and added some clk-names strings
> - USB PHY clocks are combined into a single node with #clock-cells = <1>
> 
>  .../bindings/clock/ti/davinci/da8xx-cfgchip.txt    | 93 ++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/ti/davinci/da8xx-cfgchip.txt

Reviewed-by: Rob Herring <robh@kernel.org>
