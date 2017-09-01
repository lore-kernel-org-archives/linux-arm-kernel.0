From: robh@kernel.org (Rob Herring)
Date: Fri, 1 Sep 2017 09:30:13 -0500
Subject: [PATCH v2 1/3] dt-bindings: interrupt-controller: Add Realtek
 RTD1295
In-Reply-To: <20170828105344.8338-2-afaerber@suse.de>
References: <20170828105344.8338-1-afaerber@suse.de>
 <20170828105344.8338-2-afaerber@suse.de>
Message-ID: <20170901143013.oe5frfvxlnppn6v4@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 28, 2017 at 12:53:42PM +0200, Andreas F?rber wrote:
> Add binding for Realtek RTD1295 IRQ mux.
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v1 -> v2:
>  * Dropped reference to common interrupt.txt bindings (Rob)
>  
>  .../interrupt-controller/realtek,rtd119x-mux.txt   | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/realtek,rtd119x-mux.txt

Acked-by: Rob Herring <robh@kernel.org>
