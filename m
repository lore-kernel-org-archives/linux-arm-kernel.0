From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 21 Oct 2015 09:58:14 +0100
Subject: Which is better to specify console, "console= " or "stdout-path" ?
In-Reply-To: <CAK7LNAS9uBJ1cVmGBKae3W0tk8Siu1yeXOaeN6Kz11cksMqtsg@mail.gmail.com>
References: <CAK7LNAS9uBJ1cVmGBKae3W0tk8Siu1yeXOaeN6Kz11cksMqtsg@mail.gmail.com>
Message-ID: <562753A6.3070107@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 21/10/15 06:09, Masahiro Yamada wrote:
> Hi.
>
>
> I think there exist two ways to specify the console port and baudrate.
>
>
> [1] Specify console in bootargs
>
>    chosen {
>          bootargs = "console=ttyS0,115200";
>    };
>
>
> [2] Specify stdout-path
>
>     chosen {
>           stdout-path = "serial0:115200n8";

This will work for even early/boot console, so this is better than
option [1]

-- 
Regards,
Sudeep
