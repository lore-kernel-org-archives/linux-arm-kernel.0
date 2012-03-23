From: egtvedt@samfundet.no (Hans-Christian Egtvedt)
Date: Fri, 23 Mar 2012 08:38:50 +0100
Subject: [PATCH] avr32: fix build failures from mis-naming of atmel_nand.h
In-Reply-To: <4F6B316F.5080307@atmel.com>
References: <1332296128-16262-1-git-send-email-paul.gortmaker@windriver.com>
 <20120321072632.GA15703@samfundet.no> <4F6990AF.2000004@atmel.com>
 <20120322051840.GC923@windriver.com>
 <20120322123327.GA14690@samfundet.no> <4F6B316F.5080307@atmel.com>
Message-ID: <20120323073850.GB31010@samfundet.no>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Around Thu 22 Mar 2012 15:04:31 +0100 or thereabout, Nicolas Ferre wrote:
> On 03/22/2012 01:33 PM, Hans-Christian Egtvedt :
>> Around Thu 22 Mar 2012 01:18:40 -0400 or thereabout, Paul Gortmaker wrote:

<snipp Atmel NAND cleanup>

>>>> Yes, we need to fix this. But I would not like to see this
>>>> "platform_data/atmel.h" renamed: I think that this file was designed to
>>>> collect several common platform data (ie: not just NAND related).
>>>>
>>>> So maybe we should just rename the entry that exists in
>>>> mach-at32ap/include/mach/board.h
>>>> and remove all occurrences of platform_data/atmel_nand.h
>>>
>>> Funny, since this is what I did 1st before I re-read the original commit
>>> log in more detail. :)  Oh well.  Here is the alternate solution.  You
>>> guys can pick whichever one you like best.  I compile tested this one
>>> as well.
>> 
>> I'll leave it to Nicolas to sign-off on this, but the changes look fine for
>> me.
> 
> Ok, which way do you want to follow for inclusion in mainline? I take it
> through arm-soc?

I have not gotten my key signed by any kernel developers yet, so typically
I've asked people to take it through Andrew's tree.

<snipp>

-- 
HcE
