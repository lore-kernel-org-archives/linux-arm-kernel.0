From: robh@kernel.org (Rob Herring)
Date: Wed, 20 Sep 2017 15:52:27 -0500
Subject: [PATCH v2 1/8] dt-bindings: gpu: mali-utgard: Add Rockchip
 Utgard Malis
In-Reply-To: <20170915091812.13368-2-heiko@sntech.de>
References: <20170915091812.13368-1-heiko@sntech.de>
 <20170915091812.13368-2-heiko@sntech.de>
Message-ID: <20170920131057.qsebeojud2j5blqr@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 15, 2017 at 11:18:05AM +0200, Heiko Stuebner wrote:
> Some (older or lower power) Rockchip socs use Utgard-based Mali-GPUs.
> So add the necessary compatibles for them. As the setup is the same for
> all of them (needing only the additional reset line), they get added in
> a somewhat condensed form, to not inflate the document unnecessary.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
