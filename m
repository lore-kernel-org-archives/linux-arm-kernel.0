From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 10 May 2017 12:49:39 +0200
Subject: [PATCH v2 2/2] arm: dts: mt2701: add nor flash node
In-Reply-To: <1487044733.19037.0.camel@mhfsdcap03>
References: <1485315515-29942-1-git-send-email-guochun.mao@mediatek.com>
 <1485315515-29942-3-git-send-email-guochun.mao@mediatek.com>
 <1486267249.10417.9.camel@mhfsdcap03> <20170206084544.24878633@bbrezillon>
 <77e0e3b0-2fe4-b32b-9099-11ce9811ba15@gmail.com>
 <1487044733.19037.0.camel@mhfsdcap03>
Message-ID: <1a788098-1cf8-5fec-e847-5c14189f8586@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 14/02/17 04:58, Guochun Mao wrote:
> On Sun, 2017-02-12 at 07:35 +0800, Matthias Brugger wrote:
>>
>> On 02/06/2017 08:45 AM, Boris Brezillon wrote:
>>> Hi Guochun,
>>>
>>> On Sun, 5 Feb 2017 12:00:49 +0800
>>> Guochun Mao <guochun.mao@mediatek.com> wrote:
>>>
>>>
>>>>>
>>>>> +   nor_flash: spi at 11014000 {
>>>>> +           compatible = "mediatek,mt2701-nor",
>>>>> +                        "mediatek,mt8173-nor";
>>>>> +           reg = <0 0x11014000 0 0xe0>;
>>>>> +           clocks = <&pericfg CLK_PERI_FLASH>,
>>>>> +                    <&topckgen CLK_TOP_FLASH_SEL>;
>>>>> +           clock-names = "spi", "sf";
>>>>> +           #address-cells = <1>;
>>>>> +           #size-cells = <0>;
>>>>> +           status = "disabled";
>>>>> +   };
>>>>> +
>>>>>      mmsys: syscon at 14000000 {
>>>>>              compatible = "mediatek,mt2701-mmsys", "syscon";
>>>>>              reg = <0 0x14000000 0 0x1000>;
>>>>
>>>> Hi,
>>>> mtk-quadspi.txt had been updated as suggested.
>>>> Is there suggestion about this patch?
>>>
>>> It should probably go through the Mediatek tree. Matthias, any opinion?
>>>
>>
>> Yes, I will take this one through mine tree.
>>
>> Thanks,
>> Matthias
> 
> Thanks,
> Guochun
> 
> 

Queued now for v4.12-next/dts32
Sorry for the delay.

Matthias
