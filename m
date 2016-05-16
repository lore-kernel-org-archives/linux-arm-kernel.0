From: robh@kernel.org (Rob Herring)
Date: Mon, 16 May 2016 11:04:17 -0500
Subject: [PATCH 1/4] dt: bindings: add bcm2835-memory-controller
 documentation
In-Reply-To: <1463056732-5607-2-git-send-email-kernel@martin.sperl.org>
References: <1463056732-5607-1-git-send-email-kernel@martin.sperl.org>
 <1463056732-5607-2-git-send-email-kernel@martin.sperl.org>
Message-ID: <20160516160417.GA1278@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 12, 2016 at 12:38:49PM +0000, kernel at martin.sperl.org wrote:
> From: Martin Sperl <kernel@martin.sperl.org>
> 
> Add memory controller dt-binding documentation for the
> bcm2835 soc.
> 
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> ---
>  .../bindings/memory-controllers/brcm,bcm2835-sdram.txt   | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/brcm,bcm2835-sdram.txt

I'd suspect a DDR controller has more than one clock, but otherwise 
looks fine. And this binding is pretty much independent of the 
discussion for this series.

Acked-by: Rob Herring <robh@kernel.org>
