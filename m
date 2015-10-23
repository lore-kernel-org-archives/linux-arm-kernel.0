From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 23 Oct 2015 19:54:25 +0900
Subject: [PATCH 3/3] i2c: uniphier: add bindings for UniPhier I2C
 controllers
In-Reply-To: <20151022210039.GB1516@katana>
References: <1438243942-26401-1-git-send-email-yamada.masahiro@socionext.com>
 <1438243942-26401-4-git-send-email-yamada.masahiro@socionext.com>
 <20151022210039.GB1516@katana>
Message-ID: <CAK7LNARtLzE42t3XoiSXAjwgeL=7tcC6i+baQA9hZ2U-zAiqiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-10-23 6:00 GMT+09:00 Wolfram Sang <wsa@the-dreams.de>:
> On Thu, Jul 30, 2015 at 05:12:22PM +0900, Masahiro Yamada wrote:
>> Device Tree bindings for two I2C controllers embedded in
>> UniPhier SoCs.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Please split this into two files with filenames matching those of the
> drivers. I know they will be very similar but I'd like to keep
> consistent.
>

OK, I splited it in v2.

Each document was merged into the corresponding driver patch.



-- 
Best Regards
Masahiro Yamada
