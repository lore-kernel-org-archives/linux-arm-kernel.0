From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 12 Dec 2015 15:57:47 +0900
Subject: [PATCH 0/4] arm, arm64: uniphier: add a new driver,
 device tree updates
In-Reply-To: <10682472.c84OiaBWfX@wuerfel>
References: <1448357962-12259-1-git-send-email-yamada.masahiro@socionext.com>
 <10682472.c84OiaBWfX@wuerfel>
Message-ID: <CAK7LNATcvAFr3joQ0xjZ+M+HEmPubXxj_v09r1VPfTnGtnRKpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,


Sorry for confusing you.

2015-12-12 9:12 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Tuesday 24 November 2015 18:39:18 Masahiro Yamada wrote:
>>
>> Here is another series for UniPhier SoC family:
>>
>>  - 1/4: add a new driver.  The UniPhier System Bus is an external bus
>>         where on-board devices are connected to the SoC.
>>         (please check if the binding specification is OK.)
>>
>>  - 2/4: device tree updates to use the driver added by 1/4
>>
>>  - 3/4: trivial rename of device node names
>>
>>  - 4/4: initial commit for ARMv8 SoC/Board device trees
>>
>> Please apply 2/4, 3/4/, 4/4 into the same branch because 4/4 depends on 2/4 and 3/4.
>> (4/4 creates symbolic links to ARM device trees.)
>
> I'm a bit confused how this relates to the newer version ("[PATCH v5] bus:
> uniphier-system-bus: add UniPhier System Bus driver"). The new version
> only has one patch instead of four, so I'm not sure if the patches 2, 3
> and 4 of this series still apply.
>
> Can you clarify, or send the entire series again?
>
>         Arnd


I'd like to retract this series.
Please just disregard it.


Instead, please review this one:
https://patchwork.kernel.org/patch/7714151/


Thanks!

-- 
Best Regards
Masahiro Yamada
