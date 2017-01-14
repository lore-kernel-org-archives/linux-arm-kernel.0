From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Sat, 14 Jan 2017 07:50:13 +0000
Subject: [PATCHv4 3/5] pinctrl: mvebu: pinctrl driver for 98DX3236 SoC
References: <20170113091222.7132-1-chris.packham@alliedtelesis.co.nz>
 <20170113091222.7132-4-chris.packham@alliedtelesis.co.nz>
 <2fca7ac2-9a88-19b1-28c5-5192b9c4a2bc@gmail.com>
Message-ID: <9996b6a215f944e1a47fa6239d8de21f@svr-chch-ex1.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/01/17 22:54, Sebastian Hesselbarth wrote:
> On 13.01.2017 10:12, Chris Packham wrote:
>> From: Kalyan Kinthada <kalyan.kinthada@alliedtelesis.co.nz>
>>
>> This pinctrl driver supports the 98DX3236, 98DX3336 and 98DX4251 SoCs
>> from Marvell.
>>
>> Signed-off-by: Kalyan Kinthada <kalyan.kinthada@alliedtelesis.co.nz>
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>> Acked-by: Rob Herring <robh@kernel.org>
>> Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>> ---
>>
>> Notes:
>>     Changes in v2:
>>     - include sdio support for the 98DX4251
>>     Changes in v3:
>>     - None
>>     Changes in v4:
>>     - Correct some discrepencies between binding and driver.
>
> Well, unfortunately I still see differences between the "gpio" in
> the binding and "gpo" in the driver.
>
> Please go back to that list I sent you yesterday and fix them all.
>

I think you may have missed my initial reply [1]. Or I have missed your 
response to it. Long story short "gpo" is intentional because some of 
those pins can't be used as inputs. But if you still want me to change 
it I will.

[1] - https://lkml.org/lkml/2017/1/12/117
