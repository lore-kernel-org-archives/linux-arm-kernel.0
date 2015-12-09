From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 9 Dec 2015 11:28:28 +0100
Subject: [PATCH] arm64: dts: mt8173: Add nor flash node
In-Reply-To: <CAGS+omBycHuNaMy5vuEf0ZSRTniCS50qEdAY0=L1_1Wno4EBTQ@mail.gmail.com>
References: <1449460394-31601-1-git-send-email-bayi.cheng@mediatek.com>
 <CAGS+omCuB3VGcPk3fezakdVDnFB3GAmMD+wZ_6nGdv+uHoB40g@mail.gmail.com>
 <1449462852.9118.25.camel@mhfsdcap03> <1449463619.9118.31.camel@mhfsdcap03>
 <CAGS+omBycHuNaMy5vuEf0ZSRTniCS50qEdAY0=L1_1Wno4EBTQ@mail.gmail.com>
Message-ID: <5668024C.7020509@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/12/15 09:19, Daniel Kurtz wrote:
> Bayi,
>
> On Mon, Dec 7, 2015 at 12:46 PM, bayi cheng <bayi.cheng@mediatek.com> wrote:
>> On Mon, 2015-12-07 at 12:34 +0800, bayi cheng wrote:
>>> On Mon, 2015-12-07 at 12:09 +0800, Daniel Kurtz wrote:
>>>> Bayi,
>>>>
>>>> On Mon, Dec 7, 2015 at 11:53 AM, Bayi Cheng <bayi.cheng@mediatek.com> wrote:
>>>>> Add Mediatek nor flash node
>>>>>
>>>>> Signed-off-by: Bayi Cheng <bayi.cheng@mediatek.com>
>>>>> Acked-by: Brian Norris <computersforpeace@gmail.com>
>>>>> ---
>>>>> Previous version of this patch is
>>>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/386005.html
>>>>> Drop flash node from mt8173.dtsi accroding review comment
>>>>
>>>> Is there a flash on mt8173-evb that can be accessed by the nor_flash ?
>>>> If so, can you include flash at 0 node in the mt8173-evb.dts.
>>>>
>>>> -Dan
>>>>
>>> Hi Daniel, Thanks for your comments! you are right, there is a flash on
>>> mt8173-evb which can be accessed by the nor_flash, and I will include
>>> flash at 0 node in mt8173-evb.dts (kernel v3.18) too.
>>>
>>> Bayi
>>
>> Hi Dan, I have reworked a EVB board for spi nor verify, we replaced the
>> spi nand flash with spi nor flash on EVB board,
>> and our shipping EVB board haven't support spi nor flash, So I will not
>> include flash at 0 node in the mt8173-evb.dts. I am sorry to made you
>> confused!
>
> Thanks for confirming.
>
> Reviewed-by: Daniel Kurtz <djkurtz@chromium. org>
>

Added to v4.5-next/dts
Thanks a lot.
