From: robh@kernel.org (Rob Herring)
Date: Mon, 26 Nov 2018 16:49:19 -0600
Subject: [RFC PATCH v4 04/17] dt-bindings: interrupt-controller: Add
 suniv interrupt-controller
In-Reply-To: <ea00e2cc4dadb4a661e694dd022d8ca06470d3e8.1543131714.git.mesihkilinc@gmail.com>
References: <cover.1543131714.git.mesihkilinc@gmail.com>
 <ea00e2cc4dadb4a661e694dd022d8ca06470d3e8.1543131714.git.mesihkilinc@gmail.com>
Message-ID: <20181126224919.GA11610@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 25 Nov 2018 10:43:07 +0300, Mesih Kilinc wrote:
> Add compatible string for Alwinner suniv F1C100s SoC interrupt
> controller which is stripped version of sun4i
> 
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  .../devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt   | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
