From: robh@kernel.org (Rob Herring)
Date: Tue, 30 Oct 2018 16:46:31 -0500
Subject: [PATCH v2 2/2] spi: uniphier: re-add addressing properties
In-Reply-To: <1540533525-1816-3-git-send-email-hayashibara.keiji@socionext.com>
References: <1540533525-1816-1-git-send-email-hayashibara.keiji@socionext.com>
 <1540533525-1816-3-git-send-email-hayashibara.keiji@socionext.com>
Message-ID: <20181030214631.GA16773@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 26 Oct 2018 14:58:45 +0900, Keiji Hayashibara wrote:
> In commit 7662d1dc17d4 ("spi: uniphier: fix incorrect property items")
> addressing properties of #address-cells and #size-cells were removed.
> Since it is not necessary to remove them, they are back again.
> 
> Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-uniphier.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
