From: robh@kernel.org (Rob Herring)
Date: Mon, 30 Jul 2018 15:47:05 -0600
Subject: [PATCH v2 1/2] dt-bindings: spi: add DT bindings for UniPhier
 SPI controller
In-Reply-To: <1532588943-19481-2-git-send-email-hayashibara.keiji@socionext.com>
References: <1532588943-19481-1-git-send-email-hayashibara.keiji@socionext.com>
 <1532588943-19481-2-git-send-email-hayashibara.keiji@socionext.com>
Message-ID: <20180730214705.GA25882@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2018 at 04:09:02PM +0900, Keiji Hayashibara wrote:
> From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> 
> Add DT bindings for SPI controller implemented in UniPhier SoCs.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
> ---
>  .../devicetree/bindings/spi/spi-uniphier.txt       | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-uniphier.txt

Please add acks/reviewed-bys when posting new versions.

Rob
