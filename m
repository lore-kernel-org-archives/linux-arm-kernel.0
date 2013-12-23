From: emilio@elopez.com.ar (=?UTF-8?B?RW1pbGlvIEzDs3Bleg==?=)
Date: Mon, 23 Dec 2013 10:22:05 -0300
Subject: [PATCH v3 00/13] clk: sunxi: add PLL5 and PLL6 support
In-Reply-To: <20131223054401.22761.10523@quantum>
References: <1387769564-12894-1-git-send-email-emilio@elopez.com.ar>
 <20131223054401.22761.10523@quantum>
Message-ID: <52B838FD.4050809@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

El 23/12/13 02:44, Mike Turquette escribi?:
> Quoting Emilio L?pez (2013-12-22 19:32:31)
>> Hi everyone,
>>
>> This is v3 of the sunxi clock series. For those seeing this for the
>> first time, it adds PLL4, PLL5, PLL6 and mod0 clock support on sun4i, sun5i
>> and sun7i. Additionally, mbus is supported on sun5i and sun7i. I would like
>> to see this merged for 3.14 as clock users are progressing rapidly and will
>> be needing this code, so all feedback is appreciated.
>
> For all the clock patches missing my Ack (I think just the first three):
>
> Acked-by: Mike Turquette <mturquette@linaro.org>

Great; if nobody else has any other objection I'd like to get these 
merged for 3.14. I assume you'll want a pull request as agreed on 
earlier; do you have a branch I can use as a base? These patches depend 
on the pull Maxime sent last time and is currently sitting on clk-next.

Cheers!

Emilio
