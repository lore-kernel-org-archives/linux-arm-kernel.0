From: robh@kernel.org (Rob Herring)
Date: Wed, 30 May 2018 22:13:53 -0500
Subject: [PATCH v3 1/8] dt-bindings: media: rcar-vin: Describe optional
 ep properties
In-Reply-To: <1527606359-19261-2-git-send-email-jacopo+renesas@jmondi.org>
References: <1527606359-19261-1-git-send-email-jacopo+renesas@jmondi.org>
 <1527606359-19261-2-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <20180531031353.GA4440@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2018 at 05:05:52PM +0200, Jacopo Mondi wrote:
> Describe the optional endpoint properties for endpoint nodes of port at 0
> and port at 1 of the R-Car VIN driver device tree bindings documentation.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Acked-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
> 
> ---
> v2 -> v3:
> - Do not repeat property description, just reference video-interfaces.txt
> - Indent with spaces, not tabs as the rest of the document
> - Do not remove (yet) the 'bus-width' property from example
> ---
>  Documentation/devicetree/bindings/media/rcar_vin.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
