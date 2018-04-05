From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 5 Apr 2018 08:50:03 +0200
Subject: [PATCH 00/15] ARM: pxa: switch to DMA slave maps
In-Reply-To: <CAPDyKFoFz_HgYPOMGuOTpehrTR3DtWE3uZbcnVwUwVhDy02Mow@mail.gmail.com>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
 <CAPDyKFot9dAST2jQL5s8E4U=bCHxkio=uwpqPd6S0N4FWJRB-w@mail.gmail.com>
 <874lkq4urd.fsf@belgarion.home> <20180404215623.2bf07406@bbrezillon>
 <CAPDyKFoFz_HgYPOMGuOTpehrTR3DtWE3uZbcnVwUwVhDy02Mow@mail.gmail.com>
Message-ID: <CAK8P3a1Y0X-2QQm+adXO8xNr7Z6SU6rDjZs8JhRskX-UrseyRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 5, 2018 at 8:29 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 4 April 2018 at 21:56, Boris Brezillon <boris.brezillon@bootlin.com> wrote:
>> On Wed, 04 Apr 2018 21:49:26 +0200
>> Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>>
>>> Ulf Hansson <ulf.hansson@linaro.org> writes:
>>>
>>> > On 2 April 2018 at 16:26, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>>> >> Hi,
>>> >>
>>> >> This serie is aimed at removing the dmaengine slave compat use, and transfer
>>> >> knowledge of the DMA requestors into architecture code.
>>> >> As this looks like a patch bomb, each maintainer expressing for his tree either
>>> >> an Ack or "I want to take through my tree" will be spared in the next iterations
>>> >> of this serie.
>>> >
>>> > Perhaps an option is to send this hole series as PR for 3.17 rc1, that
>>> > would removed some churns and make this faster/easier? Well, if you
>>> > receive the needed acks of course.
>>> For 3.17-rc1 it looks a bit optimistic with the review time ... If I have all
>>
>> Especially since 3.17-rc1 has been released more than 3 years ago :-),
>> but I guess you meant 4.17-rc1.
>
> Yeah, I realize that I was a bit lost in time yesterday. Even more
> people have been having fun about it (me too). :-)

I occasionally still type 2.6.17 when I mean 4.17.

       Arnd
