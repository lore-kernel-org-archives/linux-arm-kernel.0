From: robh@kernel.org (Rob Herring)
Date: Sun, 9 Jul 2017 20:08:27 -0500
Subject: [PATCH 1/9] dt-bindings: sram: Document renesas,smp-sram
In-Reply-To: <1499182903-31339-2-git-send-email-geert+renesas@glider.be>
References: <1499182903-31339-1-git-send-email-geert+renesas@glider.be>
 <1499182903-31339-2-git-send-email-geert+renesas@glider.be>
Message-ID: <20170710010827.qj2vw3fqalbzspfj@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 04, 2017 at 05:41:35PM +0200, Geert Uytterhoeven wrote:
> Document reserved SRAM for the SMP jump stub on Renesas R-Car Gen2 and
> RZ/G1 SoCs.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  .../devicetree/bindings/sram/renesas,smp-sram.txt  | 27 ++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sram/renesas,smp-sram.txt

Acked-by: Rob Herring <robh@kernel.org>
