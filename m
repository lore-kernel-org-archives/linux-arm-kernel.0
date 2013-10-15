From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 15 Oct 2013 07:13:52 -0700
Subject: [PATCH] ARM: shmobile: Genmai defconfig
In-Reply-To: <CANqRtoTWSb_MkVGbUpSQ1vtaF+ojsUKBzkyUCt5CTGAnerTsUQ@mail.gmail.com>
 (Magnus Damm's message of "Tue, 15 Oct 2013 11:00:02 +0900")
References: <cover.1381300141.git.horms+renesas@verge.net.au>
 <bb416e1d7416861bece0335f543c590d9af09c79.1381300141.git.horms+renesas@verge.net.au>
 <87vc0z4i8j.fsf@linaro.org>
 <CANqRtoTWSb_MkVGbUpSQ1vtaF+ojsUKBzkyUCt5CTGAnerTsUQ@mail.gmail.com>
Message-ID: <87siw239lr.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Magnus Damm <magnus.damm@gmail.com> writes:

> On Tue, Oct 15, 2013 at 7:09 AM, Kevin Hilman <khilman@linaro.org> wrote:
>> Simon Horman <horms+renesas@verge.net.au> writes:
>>
>>> From: Magnus Damm <damm@opensource.se>
>>>
>>> Add a defconfig for the Genmai board. In the future this board will
>>> use a shared defconfig for multiplatform, but until CCF is implemented
>>> this will be used.
>>
>> How far in the future are we talking about?
>
> My plan is to implement and upstream CCF for r7s72100 now in Q4 of 2013.

Great, thanks for the update.

>> There's already 9 defconfigs for SH-mobile.  Is this *really* the last
>> one before multi-platform support?
>
> Yes, it is! From this time all the mach-shmobile boards have to be
> multi-platform from the start.

OK, then we'll take this as the last one.

Thanks,

Kevin
