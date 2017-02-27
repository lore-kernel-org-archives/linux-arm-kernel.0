From: robh@kernel.org (Rob Herring)
Date: Mon, 27 Feb 2017 11:05:42 -0600
Subject: [PATCH 1/2] dts: mfd: axp20x: Add xpowers,master-mode property
 for AXP806 PMICs
In-Reply-To: <112c3e4aa625ce2c550ae7ae4446a61d058455b5.1487428238.git.rask@formelder.dk>
References: <cover.1487428238.git.rask@formelder.dk>
 <112c3e4aa625ce2c550ae7ae4446a61d058455b5.1487428238.git.rask@formelder.dk>
Message-ID: <20170227170541.s5ntce5njwpavnyw@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 18, 2017 at 08:51:18PM +0100, Rask Ingemann Lambertsen wrote:
> commit b101829a029a ("mfd: axp20x: Fix AXP806 access errors on cold boot")
> was intended to fix the case where a board uses an AXP806 in slave mode,
> but the boot loader leaves it in master mode for lack of AXP806 support.
> But now the driver breaks on boards where the PMIC is operating in master
> mode. To let the device tree describe which mode of operation is needed,
> this patch introduces a new property "xpowers,master-mode".
> 
> Fixes: b101829a029a ("mfd: axp20x: Fix AXP806 access errors on cold boot")
> Signed-off-by: Rask Ingemann Lambertsen <rask@formelder.dk>
> ---
>  Documentation/devicetree/bindings/mfd/axp20x.txt | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
