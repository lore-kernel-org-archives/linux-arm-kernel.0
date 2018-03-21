From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 21 Mar 2018 10:11:09 +0100
Subject: [PATCH v2 0/5] update Mediatek MT2712 clock and scpsys support
In-Reply-To: <152153061465.254778.3061562183948751301@swboyd.mtv.corp.google.com>
References: <20180312070342.4335-1-weiyi.lu@mediatek.com>
 <1521526068.13313.8.camel@mtksdaap41>
 <152153061465.254778.3061562183948751301@swboyd.mtv.corp.google.com>
Message-ID: <6c29df1f-f619-5e11-4160-b58e154f6592@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/20/2018 08:23 AM, Stephen Boyd wrote:
> Quoting Weiyi Lu (2018-03-19 23:07:48)
>> On Mon, 2018-03-12 at 15:03 +0800, Weiyi Lu wrote:
>>> This series is based on v4.16-rc1 and composed of scpsys control (PATCH 1-2) and clock control (PATCH 3-5).
>>> Basically, all changes are for the ECO design change of MT2712.
>>>
>>> changes since v1:
>>> - Avoid renumbering clocks. Append new clocks at the bottom of each own subsystem.
>>>
>> Hi Matthias & Stephen,
>>
>> Sorry to bother. Just saw patch 1/2 are already pushed to v4.16-next-soc
>> and patch 3/5 are applied onto clk-next. What about the patch 4(arm64:
>> dts: add clock device nodes of MT2712). Does there any problem remain or
>> it cause some problems? Many thanks.
> 
> Patch 4 can go via arm-soc? I'm not planning to apply that patch.
> 

I can take it through my branch, no problem. But I think it is too late for this
cycle. CCing Arnd to confirm.

Regards,
Matthias
