From: robh@kernel.org (Rob Herring)
Date: Mon, 16 Jul 2018 10:03:55 -0600
Subject: [PATCH v3 19/23] dt-bindings: thermal: armada: add reference to
 new bindings
In-Reply-To: <20180716144206.30985-20-miquel.raynal@bootlin.com>
References: <20180716144206.30985-1-miquel.raynal@bootlin.com>
 <20180716144206.30985-20-miquel.raynal@bootlin.com>
Message-ID: <20180716160355.GA15444@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2018 at 04:42:02PM +0200, Miquel Raynal wrote:
> New bindings (using a syscon) are available for AP806 and CP110
> compatibles. Add a reference to these files from the original
> documentation.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  Documentation/devicetree/bindings/thermal/armada-thermal.txt | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
