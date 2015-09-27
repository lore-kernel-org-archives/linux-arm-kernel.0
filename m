From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 27 Sep 2015 16:49:15 +0900
Subject: Debug UART for arm64 ?
In-Reply-To: <20150926070216.GA14835@leoy-linaro>
References: <CAK7LNAQcBeQfRFf25HYOnN60rnb4uU=d=Ogas+-b1TCRMAxMJA@mail.gmail.com>
 <20150926070216.GA14835@leoy-linaro>
Message-ID: <CAK7LNARJOt+H+QkbCRtJg859u9JCRecWwmt5_yGS+UmqGiGhjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leo,


2015-09-26 16:02 GMT+09:00 Leo Yan <leo.yan@linaro.org>:
> Hi,
>
> On Sat, Sep 26, 2015 at 03:24:35PM +0900, Masahiro Yamada wrote:
>> Forgive me if I am asking a silly question.
>>
>>
>> I will have to port ARM64 Linux on our new SoC.
>> This is my first work on ARM64 Linux,
>> so I have no experience with it yet.
>>
>> When I worked on ARM32 Linux porting for the first time,
>> lowlevel-debug UART (CONFIG_DEBUG_LL) was very useful for me.
>>
>> With my quick search under arch/arm64/ directory,
>> I could not find an equivalent one for ARM64.
>>
>>
>> Is debug UART available for ARM64?
>> Or, is there any other recommended easy-to-use debug facility
>> when something like a JTAG-debugger is unavailable.
>
> drivers/tty/serial/earlycon.c is like what you are looking for.


I will try this.

Thanks!




-- 
Best Regards
Masahiro Yamada
