From: emilio@elopez.com.ar (=?UTF-8?B?RW1pbGlvIEzDs3Bleg==?=)
Date: Sun, 11 May 2014 16:46:59 -0300
Subject: [PATCH] watchdog: sunxi: Fix compilation with C=2
In-Reply-To: <533EF39D.6090907@roeck-us.net>
References: <1396632265-16124-1-git-send-email-emilio@elopez.com.ar>
 <533EF39D.6090907@roeck-us.net>
Message-ID: <536FD3B3.3030100@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El 04/04/14 15:02, Guenter Roeck escribi?:
> On 04/04/2014 10:24 AM, Emilio L?pez wrote:
>> When compiling sunxi_defconfig while using C=2, the following error
>> causes the compilation to fail:
>>
>>      drivers/watchdog/sunxi_wdt.c:60:15: error: constant 0b0001 is not
>> a valid number
>>
>> Fix it by using hex notation instead of the non-standard binary one
>>
>> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>

Wim, Maxime, any comments on this?

Cheers,

Emilio
