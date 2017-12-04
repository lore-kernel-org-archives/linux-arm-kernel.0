From: robh@kernel.org (Rob Herring)
Date: Mon, 4 Dec 2017 15:48:41 -0600
Subject: [PATCH 1/3] dt-bindings: ARM: Mediatek: Fix ethsys documentation
In-Reply-To: <20171201120708.30129-1-matthias.bgg@gmail.com>
References: <20171201120708.30129-1-matthias.bgg@gmail.com>
Message-ID: <20171204214841.mkkrms5fya4pnnwz@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 01, 2017 at 01:07:06PM +0100, Matthias Brugger wrote:
> The ethsys registers a reset controller, so we need to specify a
> reset cell. This patch fixes the documentation.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt | 1 +
>  1 file changed, 1 insertion(+)

For all 3,

Reviewed-by: Rob Herring <robh@kernel.org>
