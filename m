From: holler@ahsoftware.de (Alexander Holler)
Date: Thu, 07 Apr 2011 23:59:59 +0200
Subject: [PATCH 1/2] ARM: Differentiate SheevaPlugs and DockStars on the
	basis of the memory size.
In-Reply-To: <20110407214457.GH26616@chipmunk>
References: <1302122121-3652-1-git-send-email-holler@ahsoftware.de>
	<1302122121-3652-2-git-send-email-holler@ahsoftware.de>
	<alpine.LFD.2.00.1104061739100.28032@xanadu.home>
	<4D9CED15.2010806@ahsoftware.de>
	<alpine.LFD.2.00.1104061850410.28032@xanadu.home>
	<4D9CF5B3.9020007@ahsoftware.de>
	<toa078-0do.ln1@chipmunk.wormnet.eu>
	<4D9E2D1C.7070102@ahsoftware.de> <20110407214457.GH26616@chipmunk>
Message-ID: <4D9E33DF.2020707@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 07.04.2011 23:44, schrieb Alexander Clouter:
> * Alexander Holler<holler@ahsoftware.de>  [2011-04-07 23:31:08+0200]:
>>
>> Requiring a machine ID and the needed stuff to handle that for a
>> board which just is using two GPIOs different than another board is
>> why the ARM tree exploded. And requiring a machine ID just to follow
>> the rule that a machine ID is much better than some pretty unique hw
>> feature is in my humble opinion senseless and that the resulting code
>> is more readable and better to maintain is a myth.
>>
> It's something that most people agree with you on too.  However, I am
> guessing it's around as no one else *at the time* of it's conception
> could think of a better way.
>
> Now this is why there is a lot of work being done on device-tree.
>
>> Sorry that I wanted to help there. Will not try it again.
>>
> Yeah, as obviously no tries to help anyone improve around here:

That is future, I've tried to help with the existing stuff. Maybe I 
should have suggested just to remove all boards now which never will get 
support for DT. Linux might get happy.

And than I get called that I'm writing an abomination, which would have 
been nice with just the change of one line.

Sorry guys, this isn't what motivates people, at least not without the 
needed compensations to tolerate such manners.

Regards,

Alexander
