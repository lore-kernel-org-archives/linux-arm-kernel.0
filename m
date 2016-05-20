From: robh@kernel.org (Rob Herring)
Date: Fri, 20 May 2016 14:16:45 -0500
Subject: [PATCH-V2 1/6] dt: bindings: add bcm2835-memory-controller
 documentation
In-Reply-To: <1463586030-2778-2-git-send-email-kernel@martin.sperl.org>
References: <1463586030-2778-1-git-send-email-kernel@martin.sperl.org>
 <1463586030-2778-2-git-send-email-kernel@martin.sperl.org>
Message-ID: <20160520191645.GA14779@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 18, 2016 at 03:40:25PM +0000, kernel at martin.sperl.org wrote:
> From: Martin Sperl <kernel@martin.sperl.org>
> 
> Add memory controller dt-binding documentation for the
> bcm2835 soc.
> 
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> 
> Changelog:
>   V2 -> V3: added additional clock
> 	      (for the Controller internal PLL)
> 	    added clock-names
> 	    added additional register ranges for the
> 	      SDRAM Adress and Data PHY
> 	    added reg-names
> ---
>  .../memory-controllers/brcm,bcm2835-sdram.txt      | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/brcm,bcm2835-sdram.txt

Acked-by: Rob Herring <robh@kernel.org>
