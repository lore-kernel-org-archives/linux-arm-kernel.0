From: robh@kernel.org (Rob Herring)
Date: Wed, 20 Jun 2018 12:04:13 -0600
Subject: [PATCH v3 2/4] dt-bindings: sram: Rename A64 SRAM controller
 compatible
In-Reply-To: <20180614153548.9644-3-wens@csie.org>
References: <20180614153548.9644-1-wens@csie.org>
 <20180614153548.9644-3-wens@csie.org>
Message-ID: <20180620180413.GA22870@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2018 at 11:35:46PM +0800, Chen-Yu Tsai wrote:
> The SRAM mapping controls on Allwinner SoCs is located in a block called
> "System Controls". This block also has registers for identifying the SoC,
> reading the state of an external boot-related pin, and on some newer SoCs,
> glue layer controls for the EMAC Ethernet controller.
> 
> The A64 variant compatible is renamed to "allwinner,a64-system-control"
> to reflect this. The old A64 compatible is deprecated. So far we haven't
> seen any actual use of it.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/sram/sunxi-sram.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
