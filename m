From: robh@kernel.org (Rob Herring)
Date: Wed, 20 Sep 2017 15:52:29 -0500
Subject: [PATCH v2 3/8] dt-bindings: gpu: mali-utgard: add optional
 power-domain reference
In-Reply-To: <20170915091812.13368-4-heiko@sntech.de>
References: <20170915091812.13368-1-heiko@sntech.de>
 <20170915091812.13368-4-heiko@sntech.de>
Message-ID: <20170920205229.jwnz7uyx2wi6uqd4@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 15, 2017 at 11:18:07AM +0200, Heiko Stuebner wrote:
> On some socs Mali Utgard gpu have both soc power-domains and external
> supplying regulators, so add an optional power-domains property for
> reference.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
