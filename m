From: wmb@firmworks.com (Mitch Bradley)
Date: Wed, 06 Jun 2012 06:22:57 -1000
Subject: [PATCH v2 8/9] ARM: dts: refresh dts file for arch mmp
In-Reply-To: <CAN1soZx5BiY4kgt1EzbyFqRQOAYxkX9p2sNbrxZ-D=oocZuuRw@mail.gmail.com>
References: <1336134626-12262-1-git-send-email-haojian.zhuang@gmail.com>
 <1336134626-12262-9-git-send-email-haojian.zhuang@gmail.com>
 <87d35ezkm1.fsf@laptop.org> <201206060128.28167.arnd@arndb.de>
 <4FCEB694.8080904@firmworks.com>
 <CAN1soZykbTFGk=qAmzDe2qyQVVYBJpxcPYh6OzWyPxiBacJ-mg@mail.gmail.com>
 <4FCEE91F.1030308@firmworks.com>
 <CAN1soZx5BiY4kgt1EzbyFqRQOAYxkX9p2sNbrxZ-D=oocZuuRw@mail.gmail.com>
Message-ID: <4FCF83E1.9060000@firmworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/5/2012 7:25 PM, Haojian Zhuang wrote:
> ...
>
>>> mmp2-brownstone.dts is too complex since both apb&    axi are imported.
>>>
>>> Could we only use flat structure in mmp2-brownstone.dts?
>>
>>
>> See http://dev.laptop.org/~wmb/mmp2-devicetree/mmp2-brownstone-flat.dts
>> <http://dev.laptop.org/%7Ewmb/mmp2-devicetree/mmp2-brownstone-flat.dts>
>>
>
> My meaning is mmp2-brownstone-flat.dts + mmp2.dtsi. Is it acceptable?
>

No, you must use mmp2-brownstone.dts with mmp2.dtsi .  The position of 
the uart , twsi, and rtc nodes must agree in both cases.

Do you have a use case where exposing the AXI and APB bus levels is helpful?
