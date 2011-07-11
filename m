From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 11 Jul 2011 23:13:30 +0800
Subject: zaurus patches -- arm/pxa -- is Eric alive
In-Reply-To: <20110711140303.GA32532@atrey.karlin.mff.cuni.cz>
References: <20110711134150.GA15506@localhost.ucw.cz>
	<CALT56yM+fNs_2QorWK0=gr2um1H3vDX+HXPCi9bmKDdOdSvptA@mail.gmail.com>
	<20110711140303.GA32532@atrey.karlin.mff.cuni.cz>
Message-ID: <CAMPhdO-UjxqyL47VsihX-fBD9VtAKkQqEQGj2u1YG0c90EHfqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2011 at 10:03 PM, Cyril Hrubis <metan@ucw.cz> wrote:
> Hi!
>> > There are some rather critical patches for zaurus C-3000 (spitz)
>> > available... with no response. What is going on?
>>
>> Eric seems alive. At least he've sent pull requests few days ago.
>> Maybe you can point to those patches, that you mention as critical?
>
> Perhaps the most critical one is:
>
> [PATCH] MAX1111: Fix race condition causing NULL pointer exception
>
> http://ns1.yosemitephotos.net/lists/arm-kernel/msg125356.html
>
> Which fixes memory corruption that caused random oops.
>
> And then there is a bunch of fixes for charging and power management from
> Pavel Machek:

Guys, I'm still alive, at least still breathing. Just too many mails
and I was lost.

>
> Disable CF during suspend
>
> https://lkml.org/lkml/2011/5/21/46

The fix is trivial, think I can take it. A better approach will be to have a
generic CF power control function and invoke it in pcmcia driver when
suspending.

>
> and spitz pm
>
> https://lkml.org/lkml/2011/5/21/72
> https://lkml.org/lkml/2011/5/21/73
> https://lkml.org/lkml/2011/5/21/76

Looks good to me, yet I need the last one Acked by power supply people.

>
> --
> metan
>
