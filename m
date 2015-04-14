From: wangbintian@gmail.com (Brent Wang)
Date: Tue, 14 Apr 2015 22:37:34 +0800
Subject: [PATCH v2 3/6] clk: hi6220: Document devicetree bindings for
 hi6220 clock
In-Reply-To: <5065055.RUNnjWsHWj@wuerfel>
References: <1428916660-25910-1-git-send-email-bintian.wang@huawei.com>
 <2456827.cDpE8M58pn@wuerfel> <552D09F7.7080603@huawei.com>
 <5065055.RUNnjWsHWj@wuerfel>
Message-ID: <CAAS=xmip9WeN2AXH+YpQK9Un1TCaXkHbK-cRFcr3fMcFvrfhPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

2015-04-14 21:20 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Tuesday 14 April 2015 20:37:11 Bintian wrote:
>> It's really a smart fix!
>>
>> For the four system controllers, how about change the following strings:
>> +       - "hisilicon,aoctrl"
>> +       - "hisilicon,sysctrl"
>> +       - "hisilicon,mediactrl"
>> +       - "hisilicon,pmctrl"
>>
>> to
>> +       - "hisilicon,hi6220-aoctrl"
>> +       - "hisilicon,hi6220-sysctrl"
>> +       - "hisilicon,hi6220-mediactrl"
>> +       - "hisilicon,hi6220-pmctrl"
>
> Yes, that works.
Thanks, will fix in next version.

>
>> and I also use "hisilicon,hi6220-xxxx" for hi6220 clk driver directly ?
>
> Seems fine to me, though I'd have to look at the bigger picture to see
> any potential problems. At the moment, I don't see any.
Sure, please also help to review the 6/6 patch of this patch set, many thanks!

BR,

Bintian

>
>         Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
