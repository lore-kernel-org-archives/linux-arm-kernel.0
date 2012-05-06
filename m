From: r.sricharan@ti.com (R, Sricharan)
Date: Sun, 6 May 2012 13:08:41 +0530
Subject: [PATCH 07/13] ARM: OMAP5: l3: Add l3 error handler support for
 omap5.
In-Reply-To: <20120504225153.GZ5613@atomide.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
 <1336029982-31898-8-git-send-email-r.sricharan@ti.com>
 <20120504225153.GZ5613@atomide.com>
Message-ID: <CAJ7qFSek4h78wHdwdb-h6UZNqUofT03PTm8LN66WQgdKyp5Y+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

>> - ? ? if (!(cpu_is_omap44xx()))
>> + ? ? if ((!(cpu_is_omap44xx())) && (!cpu_is_omap54xx()))
>> ? ? ? ? ? ? ? return -ENODEV;
>>
>> ? ? ? for (i = 0; i < L3_MODULES; i++) {
>
> Isn't there some unnecessary parens here?

 You mean in this above for loop?.
 There are multiple statements .

Thanks,
 Sricharan
