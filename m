From: robh@kernel.org (Rob Herring)
Date: Wed, 7 Mar 2018 15:59:20 -0600
Subject: [PATCH 1/4] dt-bindings: media: sun6i: Add A31 and H3 compatibles
In-Reply-To: <20180305100432.15009-2-maxime.ripard@bootlin.com>
References: <20180305100432.15009-1-maxime.ripard@bootlin.com>
 <20180305100432.15009-2-maxime.ripard@bootlin.com>
Message-ID: <20180307215920.wwfhj2yaf7qbssyx@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2018 at 11:04:29AM +0100, Maxime Ripard wrote:
> The H3 has a slightly different CSI controller (no BT656, no CCI) which
> looks a lot like the original A31 controller. Add a compatible for the A31,
> and more specific compatible the for the H3 to be used in combination for
> the A31.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  Documentation/devicetree/bindings/media/sun6i-csi.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
