From: holler@ahsoftware.de (Alexander Holler)
Date: Thu, 07 Apr 2011 11:44:02 +0200
Subject: [PATCH 0/2] ARM: Unify setup for Marvell SheevaPlugs and Seagate
	DockStars
In-Reply-To: <4D9D85E4.2040606@erfurth.eu>
References: <1302122121-3652-1-git-send-email-holler@ahsoftware.de>
	<4D9CEE24.1080501@erfurth.eu> <4D9D81ED.7090809@ahsoftware.de>
	<4D9D85E4.2040606@erfurth.eu>
Message-ID: <4D9D8762.3080207@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 07.04.2011 11:37, schrieb Nico Erfurth:
> Alexander Holler wrote:
>
>> I wonder how many people believe that either there will be another
>> DockStar with the same HW and GPIOs for the LEDs but more memory (and
>> still without sata) or that there will be another SheevaPlug with just
>> 128MB RAM or that someone could have a reason to change the memory
>> layout using a mem= parameter.
>>
>> For me all that is pretty unlikely.
>
> As Nicolas stated it's not just about "Oh, thats totally unlikely to
> happen!". It is about maintainable code, if somebody looks at it in 3
> years they should not think "WTF?!?!". Using machine ids and the
> generated macros helps to keep the code clean and readable.

Sorry, I can't agree. For me some unique hardware identifier is more 
reasonable, than some machine id which comes from outerspace.

And in no way I see any argument for that "clean and readable", at least 
not in the patch I posted.

Anyway, I leave this discussion and wish all a nice day.

Regards,

Alexander
