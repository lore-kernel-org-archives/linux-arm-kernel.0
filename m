From: robh@kernel.org (Rob Herring)
Date: Wed, 17 Oct 2018 15:00:22 -0500
Subject: [PATCH v2 2/2] dt-bindings: uniphier: move cache-uniphier.txt to
 vendor directory
In-Reply-To: <1539318324-4938-2-git-send-email-yamada.masahiro@socionext.com>
References: <1539318324-4938-1-git-send-email-yamada.masahiro@socionext.com>
 <1539318324-4938-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20181017200022.GA14782@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 12 Oct 2018 13:25:24 +0900, Masahiro Yamada wrote:
> Now, the Socionext vendor directory is available at
> Documentation/devicetree/bindings/arm/socionext/
> 
> Move cache-uniphier.txt over to it.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v2:
>   - New patch
> 
>  .../devicetree/bindings/arm/{uniphier => socionext}/cache-uniphier.txt    | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/arm/{uniphier => socionext}/cache-uniphier.txt (100%)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
