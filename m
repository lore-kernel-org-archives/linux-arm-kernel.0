From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 23 Oct 2015 19:59:54 +0900
Subject: [PATCH 2/3] i2c: uniphier_f: add UniPhier FIFO-builtin I2C driver
In-Reply-To: <20151022210618.GC1516@katana>
References: <1438243942-26401-1-git-send-email-yamada.masahiro@socionext.com>
 <1438243942-26401-3-git-send-email-yamada.masahiro@socionext.com>
 <20151022210618.GC1516@katana>
Message-ID: <CAK7LNATNazGG74DYvPXPUf5WE6K4356OzJnbxv4DuKjGC_g+kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-10-23 6:06 GMT+09:00 Wolfram Sang <wsa@the-dreams.de>:
> On Thu, Jul 30, 2015 at 05:12:21PM +0900, Masahiro Yamada wrote:
>> Add support for on-chip I2C controller used on newer UniPhier SoCs
>> such as PH1-Pro4, PH1-Pro5, etc.  This adapter is equipped with
>> 8-depth TX/RX FIFOs.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Same comments as for the other driver.

Fixed in v2.

> And quite some debug messages left. Could you check if you still want
> them or if they were mostly useful during development of the driver?

Yes, I want to keep them.  I do not think they are too much.


I will probably come back to these drivers when I find some time
in order to implement further features such as the slave mode.   :)

dev_dbg() might be useful for the new development
as well as for checking something when hardware went wrong for some reason.


-- 
Best Regards
Masahiro Yamada
