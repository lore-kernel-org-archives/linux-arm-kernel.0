From: robh@kernel.org (Rob Herring)
Date: Wed, 20 Dec 2017 15:46:46 -0600
Subject: [PATCH v3 02/20] dt-bindings: gpio: Add ASPEED constants
In-Reply-To: <20171220032328.30584-3-joel@jms.id.au>
References: <20171220032328.30584-1-joel@jms.id.au>
 <20171220032328.30584-3-joel@jms.id.au>
Message-ID: <20171220214646.sschcq35fnonxiix@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 20, 2017 at 01:53:10PM +1030, Joel Stanley wrote:
> These are used to by the device tree to map pin numbers to constants
> required by the GPIO bindings.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> --
> v3:
>  - Remove dtsi includes from this patch, they will come later
> ---
>  include/dt-bindings/gpio/aspeed-gpio.h | 49 ++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 include/dt-bindings/gpio/aspeed-gpio.h

Reviewed-by: Rob Herring <robh@kernel.org>
