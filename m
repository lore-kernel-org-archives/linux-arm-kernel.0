From: r.sricharan@ti.com (R, Sricharan)
Date: Tue, 8 May 2012 11:34:05 +0530
Subject: [PATCH 07/13] ARM: OMAP5: l3: Add l3 error handler support for
 omap5.
In-Reply-To: <20120507173430.GC5088@atomide.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
 <1336029982-31898-8-git-send-email-r.sricharan@ti.com>
 <20120504225153.GZ5613@atomide.com>
 <CAJ7qFSek4h78wHdwdb-h6UZNqUofT03PTm8LN66WQgdKyp5Y+A@mail.gmail.com>
 <20120507173430.GC5088@atomide.com>
Message-ID: <CAJ7qFSdE50KH0YdyiiDccPZ9oduM4ktwXDm+h2OvgXRvmm-LAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

On Mon, May 7, 2012 at 11:04 PM, Tony Lindgren <tony@atomide.com> wrote:
> * R, Sricharan <r.sricharan@ti.com> [120506 00:42]:
>> Hi Tony,
>>
>> >> - ? ? if (!(cpu_is_omap44xx()))
>> >> + ? ? if ((!(cpu_is_omap44xx())) && (!cpu_is_omap54xx()))
>> >> ? ? ? ? ? ? ? return -ENODEV;
>> >>
>> >> ? ? ? for (i = 0; i < L3_MODULES; i++) {
>> >
>> > Isn't there some unnecessary parens here?
>>
>> ?You mean in this above for loop?.
>> ?There are multiple statements .
>
> No, both the old (!(cpu_is_omap44xx())) and the added one.
>
  oh ok, will remove those extra ones. Thanks.

Thanks,
 Sricharan
