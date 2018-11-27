From: robh@kernel.org (Rob Herring)
Date: Mon, 26 Nov 2018 19:40:13 -0600
Subject: [RFC PATCH v4 15/17] dt-bindings: watchdog: Add Allwinner ARMv5
 F1C100s wdt
In-Reply-To: <29723ab4d09399185b8807a3f20bb2551b940f2f.1543131714.git.mesihkilinc@gmail.com>
References: <cover.1543131714.git.mesihkilinc@gmail.com>
 <29723ab4d09399185b8807a3f20bb2551b940f2f.1543131714.git.mesihkilinc@gmail.com>
Message-ID: <20181127014013.GA25898@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 25 Nov 2018 10:43:18 +0300, Mesih Kilinc wrote:
> Allwinner ARMv5 F1C100s has similar watchdog timer to sun6i A31.
> Add definition for it.
> 
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> ---
>  Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
