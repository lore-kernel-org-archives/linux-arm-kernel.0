From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 09 Nov 2014 19:04:54 +0100
Subject: [PATCH] arm: xscale: correct auxiliary register in suspend/resume
In-Reply-To: <CALT56yMg53Dd0iKc-8zwSeRaAJbTnsx9akod_V+X=1t5VN+VKA@mail.gmail.com>
 (Dmitry Eremin-Solenikov's message of "Sun, 9 Nov 2014 20:14:53
 +0400")
References: <1415479134-19999-1-git-send-email-dbaryshkov@gmail.com>
 <87oasgv1nc.fsf@free.fr>
 <CALT56yMg53Dd0iKc-8zwSeRaAJbTnsx9akod_V+X=1t5VN+VKA@mail.gmail.com>
Message-ID: <87k334uu61.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:

> Noticed thanks to qemu that reported 'unsupported instruction' on suspend.
>
>>  - did you test this patch during a suspend/resume cycle, and if so on which
>>    variants (pxa25x and tosa maybe) ?
>
> Tested on tosa (that is pxa255).
>
>>
>> As you might haved guessed, I'd like all these questions to have an answer in
>> the commit message.
>
> Do you need an updated message?
In a couple of days, if you don't have any other comments, yes please.

And I think the patch subject would rather be "ARM: xscale: ..." if I judge by
the other patches in that area.

And as I tested that also on pxa270 and found no regression, with my:
Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

-- 
Robert
