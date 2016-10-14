From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 14 Oct 2016 20:21:46 +0200
Subject: [PATCH v3 1/2] devicetree: Add vendor prefix for Rikomagic
In-Reply-To: <d51c7719a314f723a0a69b932997502a2fe0e3ee.1475957884.git.paweljarosz3691@gmail.com>
References: <cover.1475957884.git.paweljarosz3691@gmail.com>
 <d51c7719a314f723a0a69b932997502a2fe0e3ee.1475957884.git.paweljarosz3691@gmail.com>
Message-ID: <7746988.aAT8rmUZDV@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag, 8. Oktober 2016, 22:22:05 CEST schrieb Pawe? Jarosz:
> Add Rikomagic to vendor-prefixes.txt
> 
> Signed-off-by: Pawe? Jarosz <paweljarosz3691@gmail.com>
> ---
> 
> Changes in v2:
> - none
> 
> Changes in v3:
> - none
> 
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt
> b/Documentation/devicetree/bindings/vendor-prefixes.txt index
> 69caf14..3edfa08 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -224,6 +224,7 @@ realtek Realtek Semiconductor Corp.
>  renesas	Renesas Electronics Corporation
>  richtek	Richtek Technology Corporation
>  ricoh	Ricoh Co. Ltd.
> +rikomagic	Rikomagic
				^ Rikomagic Tech Corp. Ltd

(according to http://www.rikomagic.com/en/index.html)

But I can change that myself. I'll just need to wait a bit more if Rob or Mark 
want to Ack this vendor-prefix addition.


Heiko
