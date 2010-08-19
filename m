From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Thu, 19 Aug 2010 22:34:30 +0400
Subject: [PATCH 3/6] OMAP3: PM: ensure IO wakeups are properly disabled
In-Reply-To: <87sk2ao4fr.fsf@deeprootsystems.com>
References: <20100813080034.18750.15410.stgit@baageli.muru.com>	<20100813080200.18750.37791.stgit@baageli.muru.com>	<4C651635.8000201@ru.mvista.com>
	<20100813102933.GN12706@atomide.com>	<4C65238D.9080105@ru.mvista.com>
	<87sk2ao4fr.fsf@deeprootsystems.com>
Message-ID: <4C6D7936.3090201@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Kevin Hilman wrote:

>>>>> From: Kevin Hilman <khilman@ti.com>
>>>>> Commit 5a5f561 (convert OMAP3 PRCM macros to the _SHIFT/_MASK suffixes)
>>>>> mistakenly removed the check for PER when disabling the IO chain.
>>>>> During idle, if the PER powerdomain transitions and CORE does not (as

>>>>   Does not what?

>>> How about ".. and CORE does not transition"?

>>    Transition to what then? Sentense till won't parse right...

>>> Kevin, care to clarify that?
>>    Yeah, looks like a considerable partt of that sentense got omitted...

> No.  Nothing was omitted.  

> It's like saying "Tony drinks Fernet and Kevin does not."  Adding an
> additional "drinks Fernet" at the end is redundant.

    Sorry, the sentence still doesn't parse for me. You don't say "Fernet" 
there BTW, so it's not clear where the PER powerdomain transitions to. What 
goes after the closing parenthesis doesn't clear things up either, it just 
describes what happens if...

> Kevin

WBR, Sergei
