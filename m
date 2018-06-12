From: robh@kernel.org (Rob Herring)
Date: Tue, 12 Jun 2018 15:53:37 -0600
Subject: [PATCH 1/4] dt-bindings: arm: remove PMC bindings
In-Reply-To: <20180607084107.4461-2-alexandre.belloni@bootlin.com>
References: <20180607084107.4461-1-alexandre.belloni@bootlin.com>
 <20180607084107.4461-2-alexandre.belloni@bootlin.com>
Message-ID: <20180612215337.GA6569@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 07, 2018 at 10:41:04AM +0200, Alexandre Belloni wrote:
> The PMC bindings are fully described in
> Documentation/devicetree/bindings/clock/at91-clock.txt. Remove the
> duplicate and incomplete documentation.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  .../devicetree/bindings/arm/atmel-pmc.txt          | 14 --------------
>  1 file changed, 14 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/atmel-pmc.txt

Acked-by: Rob Herring <robh@kernel.org>
