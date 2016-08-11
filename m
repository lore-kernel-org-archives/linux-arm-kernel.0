From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 11 Aug 2016 17:48:50 +0200
Subject: [PATCH 1/3] dt-bindings: thermal: Add binding document for
 Mediatek thermal controller
In-Reply-To: <1468227124.15776.29.camel@mtksdaap41>
References: <1467882386-40544-1-git-send-email-dawei.chien@mediatek.com>
 <1467882386-40544-2-git-send-email-dawei.chien@mediatek.com>
 <577E385C.9080501@ti.com> <1468227124.15776.29.camel@mtksdaap41>
Message-ID: <8886eba0-7f3d-edf8-c6fb-a6535b3717da@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/07/16 10:52, dawei chien wrote:
> Dear Keerthy,
>
> On Thu, 2016-07-07 at 16:39 +0530, Keerthy wrote:
>>
>> On Thursday 07 July 2016 02:36 PM, Dawei Chien wrote:
>>> This adds the device tree binding documentation for the mediatek thermal
>>> controller found on Mediatek MT2701.
>>>
>>> Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
>>> ---
>>>   .../bindings/thermal/mediatek-thermal.txt          |    2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
>>> index 81f9a51..bb55e79 100644
>>> --- a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
>>> +++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
>>> @@ -8,7 +8,7 @@ apmixedsys register space via AHB bus accesses, so a phandle to the APMIXEDSYS
>>>   is also needed.
>>>
>>>   Required properties:
>>> -- compatible: "mediatek,mt8173-thermal"
>>> +- compatible: "mediatek,mt8173-thermal" or "mediatek,mt2701-thermal"
>>
>> - compatible :
>>   - "mediatek,mt8173-thermal" : For MT8173 family of SoCs
>>   - "mediatek,mt2701-thermal" : For MT2701 family of SoCs
>
> Thank you, I will update it on next version.
>

Do you know about the compability to older SoCs (e.g. mt6589)?
It might make sense to add mediatek,mtk-thermal if they are compatible 
or nearly compatible.

>>
>>>   - reg: Address range of the thermal controller
>>>   - interrupts: IRQ for the thermal controller
>>>   - clocks, clock-names: Clocks needed for the thermal controller. required
>>>
>
>
