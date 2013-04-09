From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 9 Apr 2013 13:23:27 +0200
Subject: [RFC PATCH arm: initial TI-Nspire support]
In-Reply-To: <201304072323.42173.arnd@arndb.de>
References: <6FE4B33E-A503-4A75-AEED-831CB2C06D83@gmail.com>
 <4B3FD561-84FC-40CD-B747-13851692D673@gmail.com>
 <521DFDFC-7E9E-47EA-ACDA-C91BBDC8454E@gmail.com>
 <201304072323.42173.arnd@arndb.de>
Message-ID: <CACRpkda9Nue-8Esp3cJ6u2-MJ2ZL8hH-2BnrhHwWv4GZP2VR5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 7, 2013 at 11:23 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Sunday 07 April 2013, Daniel Tang wrote:
>> Here's an updated patch that enables support for the LCD.
>>
>> I looked into drivers/video/of_display_timing.c but it doesn't have the fields to describe the
>> PL11x specific options needed in struct clcd_panel. At the moment, it is implemented by
>> hardcoding the values in the kernel and using the device tree to select the correct
>> configuration.
>>
>> Signed-off-by: Daniel Tang <dt.tangr@gmail.com>
>
> I think you should for now keep the clcd stuff in a separate file,
> since it will be replaced with DT logic eventually. For now, the
> auxdata method is ok, but Linus Walleij might already have thought
> about how pl111 should get all its data from the device tree.

So last thing I heard there was *someone* at ARM working on
device tree support for the PL110/PL111, so I just don't know who
this was.

But I bet Pawel knows, because it will be needed for all
ARM reference designs.

Yours,
Linus Walleij
