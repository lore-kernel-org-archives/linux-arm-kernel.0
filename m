From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 14 Jan 2013 08:51:13 +0100
Subject: [PATCH 02/11] ARM: nomadik: initial devicetree support
In-Reply-To: <1358148382.2198.2.camel@gitbox>
References: <1357599359-7385-1-git-send-email-linus.walleij@linaro.org>
 <1358148382.2198.2.camel@gitbox>
Message-ID: <CACRpkdafi_0ERh6A8BVNXp8k0p2zA9NUWNUfHc-Nvhe=KCuJ0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 8:26 AM, Tony Prisk <linux@prisktech.co.nz> wrote:

>> +struct sys_timer cpu8815_of_timer = {
>> +     .init   = cpu8815_timer_init_of,
>> +};
>> +
>
> struct sys_timer is disappearing in 3.9

I know, but I have to develop against something.

Do you know if there a now a frozen branch I can base my
patches on?

Yours,
Linus Walleij
