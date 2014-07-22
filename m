From: xerofoify@gmail.com (Nick Krause)
Date: Tue, 22 Jul 2014 13:46:35 -0400
Subject: Fix me in netx-regs.h
In-Reply-To: <11713455.tffm2SOdyn@wuerfel>
References: <CAPDOMVhdK67Fc5KsamL8XKdRNy0VjKB3ub24krgwmRsnZGtQNQ@mail.gmail.com>
 <11713455.tffm2SOdyn@wuerfel>
Message-ID: <CAPDOMVj6=Ug1DW_bcDrOd9aXAem76aanoAoA6ZkDqUp0MT2Ssw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 22, 2014 at 4:44 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 22 July 2014 00:16:26 Nick Krause wrote:
>> Hey Russell,
>> I did give thought to our previous conversations and I will still do
>> fix mes but am going to be more careful
>> with I submit them. Furthermore it seems  #define
>> NETX_GPIO_COUNTER_CTRL_GPIO_RE is not defined
>> correctly. As the maintainer what should I define it to?
>
> Are you offering to become the maintainer for netx?
>
> Try to get hold of a reference manual for the chip. More importantly
> than the fixme, I think we should be able to move this platform into
> ARCH_MULTIPLATFORM. This means moving the contents of the header files
> into the places where they are used, and finding a better home for the
> pfifo driver.
>
>         Arnd

Arnd,
I am not asking to me the maintainer of netx.
I was just trying to help out.
Cheers Nick
