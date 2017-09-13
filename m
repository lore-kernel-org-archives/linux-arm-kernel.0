From: robh@kernel.org (Rob Herring)
Date: Wed, 13 Sep 2017 13:07:34 -0500
Subject: [PATCH v5 02/10] dt-bindings: net: Restore sun8i dwmac binding
In-Reply-To: <20170908071156.5115-3-clabbe.montjoie@gmail.com>
References: <20170908071156.5115-1-clabbe.montjoie@gmail.com>
 <20170908071156.5115-3-clabbe.montjoie@gmail.com>
Message-ID: <20170913180734.xvazvf7thpqtssgz@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 08, 2017 at 09:11:48AM +0200, Corentin Labbe wrote:
> This patch restore dt-bindings documentation about dwmac-sun8i
> This reverts commit 8aa33ec2f481 ("dt-bindings: net: Revert sun8i dwmac binding")

Why?

> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  .../devicetree/bindings/net/dwmac-sun8i.txt        | 84 ++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/dwmac-sun8i.txt

Otherwise,

Acked-by: Rob Herring <robh@kernel.org>
