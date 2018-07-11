From: robh@kernel.org (Rob Herring)
Date: Wed, 11 Jul 2018 07:51:12 -0600
Subject: [PATCH v5 1/6] dt-bindings: media: rcar-vin: Align Gen2 and Gen3
In-Reply-To: <1531145962-1540-2-git-send-email-jacopo+renesas@jmondi.org>
References: <1531145962-1540-1-git-send-email-jacopo+renesas@jmondi.org>
 <1531145962-1540-2-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <20180711135112.GA12419@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 09, 2018 at 04:19:16PM +0200, Jacopo Mondi wrote:
> Align description of the Gen2 and Gen3 bindings for parallel input.
> This commit prepares for description of optional endpoint properties in ports
> subnodes accepting parallel video connections.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
>  Documentation/devicetree/bindings/media/rcar_vin.txt | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
