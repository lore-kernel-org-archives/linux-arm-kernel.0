From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 24 Jan 2015 15:18:11 +0100
Subject: [GIT PULL RESEND] pxa for v3.20
In-Reply-To: <20150123215423.GD20896@quad.lixom.net> (Olof Johansson's message
 of "Fri, 23 Jan 2015 13:54:23 -0800")
References: <87egqpff9m.fsf@free.fr> <20150123215423.GD20896@quad.lixom.net>
Message-ID: <874mrgdzz0.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson <olof@lixom.net> writes:

> Hi Robert,
>
> Branch looks good, I'll merge this into next/fixes-non-critical. One nit below
> though:
>
>> ----------------------------------------------------------------
>> Dmitry Eremin-Solenikov (3):
>>       ARM: pxa: add regulator_has_full_constraints to corgi board file
>>       ARM: pxa: add regulator_has_full_constraints to poodle board file
>>       ARM: pxa: add regulator_has_full_constraints to spitz board file
>> 
>> Martin Vajnar (1):
>>       hx4700: regulator: declare full constraints
>
> Please use consistent patch subjects in the future. We've ended up using ARM:
> <platform>: <foo> across all platforms these days.
>
> I'm not going to ask you to respin just for this, but please remember to fix
> future patches when you apply them if they're not already correct.
You're right, I missed that one.

In case you've not already pulled, I created :
   https://github.com/rjarzmik/linux.git tags/pxa-for-3.20-bis

I can resend a proper pull request if you wish, or we can leave it as is if you
already pulled. In any case I'll be more carefull next time, maybe I can
convince my bot to check that for me too.

Or even better checkpatch could check that any patch with a diffstat fully in
arch/arm/{mach,plat}-<XYZ> has a subject beginning with "ARM: XYZ: ", that would
be cool, and put the burden on others as well :)

Cheers.

-- 
Robert
