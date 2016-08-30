From: robh@kernel.org (Rob Herring)
Date: Tue, 30 Aug 2016 18:09:08 -0500
Subject: [PATCH 04/10] dt-bindings: spi-nor: Update bindings for LS1012A
In-Reply-To: <1472207269-18499-4-git-send-email-Bhaskar.Upadhaya@nxp.com>
References: <1472207269-18499-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
 <1472207269-18499-4-git-send-email-Bhaskar.Upadhaya@nxp.com>
Message-ID: <CAL_Jsq+bXYeKJSKzpVaUsKAbX-4TFk1QerqQHDudurGhtRzb3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 26, 2016 at 5:27 AM, Bhaskar Upadhaya
<Bhaskar.Upadhaya@nxp.com> wrote:

Make the subject reflect what the patch does.

> Signed-off-by: Bhaskar Upadhaya <Bhaskar.Upadhaya@nxp.com>
> ---
>  Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
> index 2c91c03..fc99ef2 100644
> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
> @@ -13,6 +13,7 @@ Required properties:
>                   at25df321a
>                   at25df641
>                   at26df081a
> +                eon,en25s64

To answer Scott's question, see the paragraph above this.

Rob
