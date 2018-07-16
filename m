From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 16 Jul 2018 15:37:06 +0200
Subject: [PATCH 7/7] arm64: dts: mt7622: add earlycon to mt7622-rfb1 board
In-Reply-To: <4a8b1000e7d8979b0c6c6f9836296b7dd382f6cd.1529639050.git.sean.wang@mediatek.com>
References: <f222c9f488490bd86d35346e725491e1de306ace.1529639050.git.sean.wang@mediatek.com>
 <4a8b1000e7d8979b0c6c6f9836296b7dd382f6cd.1529639050.git.sean.wang@mediatek.com>
Message-ID: <961bc8b0-cc5d-0796-0c4d-3d83b7cd96cd@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 22/06/18 05:49, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Add earlycon to mt7622-rfb1 as to know what was going on when a certain
> fault is happening at the early initialization stage.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)


pushed now to v4.18-next/dts64

Thanks
Matthias

> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
> index 1ff003e..a747b7b 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
> @@ -18,7 +18,7 @@
>  	compatible = "mediatek,mt7622-rfb1", "mediatek,mt7622";
>  
>  	chosen {
> -		bootargs = "console=ttyS0,115200n1 swiotlb=512";
> +		bootargs = "earlycon=uart8250,mmio32,0x11002000 console=ttyS0,115200n1 swiotlb=512";
>  	};
>  
>  	cpus {
> 
