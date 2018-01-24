From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 24 Jan 2018 16:13:10 +0100
Subject: [PATCH 2/3] arm64: dts: mt6797: add pwrap support for mt6797
In-Reply-To: <20180123033659.11401-2-argus.lin@mediatek.com>
References: <20180123033659.11401-1-argus.lin@mediatek.com>
 <20180123033659.11401-2-argus.lin@mediatek.com>
Message-ID: <02292414-1f47-8614-df89-3e5653aecc70@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/23/2018 04:36 AM, argus.lin at mediatek.com wrote:
> From: Argus Lin <argus.lin@mediatek.com>
> 
> mt6797 is a highly integrated SoCs, and it uses
> mt6351 as Power Management IC.
> We need to add pwrap device to communicate with
> mt6351 by SPI.
> The base address of pwrap is 0x1000d000, and IRQ
> number is 178. It also using fixed 26Mhz clock
> as SPI CLK.
> 
> Change-Id: I07a8b794a019c2a980bb1f974defeff4e7df5693

No Change-Ids please :)
