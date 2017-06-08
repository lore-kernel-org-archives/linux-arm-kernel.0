From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 8 Jun 2017 16:37:11 +0200
Subject: [PATCH v3 1/3] dt-bindings: mediatek: add bindings for MediaTek
 MT7622 SoC
In-Reply-To: <20170607213028.xsbgwwjgbgghk3vg@rob-hp-laptop>
References: <cover.1496250798.git.sean.wang@mediatek.com>
 <1b9dd0df077a59aea5a15e3cb7775f80224b0b06.1496250798.git.sean.wang@mediatek.com>
 <20170607213028.xsbgwwjgbgghk3vg@rob-hp-laptop>
Message-ID: <dc04ea44-4f4c-a914-2f92-266b3d11eb54@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/06/17 23:30, Rob Herring wrote:
> On Thu, Jun 01, 2017 at 01:28:59AM +0800, sean.wang at mediatek.com wrote:
>> From: Sean Wang <sean.wang@mediatek.com>
>>
>> This adds dt-binding documentation for MediaTek MT7622 SoC
>> which currently only includes basic items such as ARM CPU,
>> MediaTek SYSIRQ and UART.
>>
>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
>> ---
>>   Documentation/devicetree/bindings/arm/mediatek.txt                    | 4 ++++
>>   .../devicetree/bindings/interrupt-controller/mediatek,sysirq.txt      | 3 ++-
>>   Documentation/devicetree/bindings/serial/mtk-uart.txt                 | 1 +
>>   3 files changed, 7 insertions(+), 1 deletion(-)
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 

Pushed this one to v4.12-next/dts64

Thanks,
Matthias
