From: manabian@gmail.com (Joachim Eastwood)
Date: Mon, 13 Apr 2015 13:59:32 +0200
Subject: NXP LPC3250 broken?
In-Reply-To: <552B77CA.2070604@antcom.de>
References: <CAGhQ9VysMCJzRYz-C_VmWqBAVKXfh2ydq5iNu96RxfD4k0cWvw@mail.gmail.com>
 <552B77CA.2070604@antcom.de>
Message-ID: <CAGhQ9VznbxkAPquM9FXAw44bE5N3SJxn+TGtySUkCgDGYTH6wA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 April 2015 at 10:01, Roland Stigge <stigge@antcom.de> wrote:
> Hi,
>
> have you tried to compare with an NXP dev kit?

No, the EA board is the only one I got.

> I also have an EA board but not currently connected. Will need to test
> when I have access to it again.

Okey, sounds good.

Which EA board do you have, btw?
The old one with the display or the v2?

regards,
Joachim Eastwood

> Thanks for reporting,
>
> Roland
>
>
> On 04/12/2015 04:20 PM, Joachim Eastwood wrote:
>> Hi,
>>
>> I recently got a Embedded Artist LPC3250 (ea3250.dts) board that I
>> wanted to test mainline Linux on.
>>
>> But with lpc32xx_defconfig, ea3250.dts and the latest rc (v4.0-rc7) I am
>> not getting very far.
>>
>> First I got a "kernel NULL pointer dereference". See
>> http://slexy.org/raw/s211rzbZL1
>> I got around this one by disabling the leds-gpio driver.
>>
>> Then, without leds-gpio, I get an endless stream of "unexpected IRQ trap
>> at vector 00" messages.
>> See: http://slexy.org/raw/s2S5Z9TtoV
>>
>> I also tried an older kernel (3.18). This one seemed at first to hang
>> but after a short while I got lots of backtraces which seem to involve
>> rcu, tick and timer interrupt.
>> See: http://slexy.org/raw/s2024RXCkX
>>
>> Does anyone got any ideas on what may be going on?
>>
>>
>> When I get a bit more time to play around with the kit I will try even
>> older kernels to see if I can get it working at all.
>>
>> best regards,
>> Joachim Eastwood
>
