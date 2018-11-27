From: robh@kernel.org (Rob Herring)
Date: Mon, 26 Nov 2018 19:39:54 -0600
Subject: [RFC PATCH v4 14/17] dt-bindings: sram: Add Allwinner suniv
 F1C100s
In-Reply-To: <f80ca2de497c44c9415b02ac9aba93721d723730.1543131714.git.mesihkilinc@gmail.com>
References: <cover.1543131714.git.mesihkilinc@gmail.com>
 <f80ca2de497c44c9415b02ac9aba93721d723730.1543131714.git.mesihkilinc@gmail.com>
Message-ID: <20181127013954.GA25380@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 25 Nov 2018 10:43:17 +0300, Mesih Kilinc wrote:
> The suniv ARMv5 F1C100s chip has similar sram controller to sun4i A10.
> Add compatible string for it.
> 
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> ---
>  Documentation/devicetree/bindings/sram/sunxi-sram.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
