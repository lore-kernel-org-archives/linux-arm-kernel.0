From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 26 Oct 2015 17:27:22 +0900
Subject: [PATCH v2 0/2] i2c: uniphier: add two I2C controller drivers for
 UniPhier SoC platform
In-Reply-To: <20151026081746.GC597@x1>
References: <1445597520-6299-1-git-send-email-yamada.masahiro@socionext.com>
 <20151026081746.GC597@x1>
Message-ID: <CAK7LNATVmVi=4ugv0MgoCUzusphNeAXTC_K-PsXDiTLoCkV4-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,


2015-10-26 17:17 GMT+09:00 Lee Jones <lee.jones@linaro.org>:
>> This series adds two I2C controller drivers.
>> (they are completely different IPs.)
>>
>> The first one is a very simple FIFO-less I2C controller,
>> which is used on some older UniPhier SoCs.
>>
>> The other one is higher-performance I2C controller with TX/RX FIFO,
>> used on newer UniPhier SoCs.
>
> And you have sent this to me because ... ?


No special reason.


I sent this series to linux-i2c at vger.kernel.org.

I guess you were automatically CC'ed by scripts/get_maintainer.pl.

Using get_maintainer.pl is a normal process when sending patches, I think.





-- 
Best Regards
Masahiro Yamada
