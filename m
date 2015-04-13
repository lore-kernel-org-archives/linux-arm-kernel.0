From: manabian@gmail.com (Joachim Eastwood)
Date: Mon, 13 Apr 2015 17:19:17 +0200
Subject: NXP LPC3250 broken?
In-Reply-To: <5023825.DuPpA61AdY@wuerfel>
References: <CAGhQ9VysMCJzRYz-C_VmWqBAVKXfh2ydq5iNu96RxfD4k0cWvw@mail.gmail.com>
 <CAGhQ9VznbxkAPquM9FXAw44bE5N3SJxn+TGtySUkCgDGYTH6wA@mail.gmail.com>
 <552BBE2F.8010403@antcom.de> <5023825.DuPpA61AdY@wuerfel>
Message-ID: <CAGhQ9Vx5P-U0k0+Mjf8GxDf3j8RaNsHEGXSSKOrwo6rCgz5Xzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 April 2015 at 15:26, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 13 April 2015 15:01:35 Roland Stigge wrote:
>> On 04/13/2015 01:59 PM, Joachim Eastwood wrote:
>> >> I also have an EA board but not currently connected. Will need to test
>> >> when I have access to it again.
>> >
>> > Okey, sounds good.
>> >
>> > Which EA board do you have, btw?
>> > The old one with the display or the v2?
>>
>> The one w/ the display. Would be interesting to support the v2 also, though!
>
> Sorry for highjacking the thread, but if one of you is still actively working
> on lpc32xx stuff, would you be able to convert arch/arm/mach-lpc32xx/clock.c
> to a proper driver for drivers/clk?

I am currently looking at it, but I won't promise anything.

regards,
Joachim Eastwood

> I'd like to see the platform get converted to use ARCH_MULTIPLATFORM
> eventually, and this is the main showstopper.
>
>         Arnd
