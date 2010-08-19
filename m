From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu, 19 Aug 2010 11:14:32 -0700
Subject: [PATCH 3/6] OMAP3: PM: ensure IO wakeups are properly disabled
In-Reply-To: <4C65238D.9080105@ru.mvista.com> (Sergei Shtylyov's message of
	"Fri, 13 Aug 2010 14:50:53 +0400")
References: <20100813080034.18750.15410.stgit@baageli.muru.com>
	<20100813080200.18750.37791.stgit@baageli.muru.com>
	<4C651635.8000201@ru.mvista.com> <20100813102933.GN12706@atomide.com>
	<4C65238D.9080105@ru.mvista.com>
Message-ID: <87sk2ao4fr.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sergei Shtylyov <sshtylyov@mvista.com> writes:

> Hello.
>
> Tony Lindgren wrote:
>
>>>> From: Kevin Hilman <khilman@ti.com>
>>>> Commit 5a5f561 (convert OMAP3 PRCM macros to the _SHIFT/_MASK suffixes)
>>>> mistakenly removed the check for PER when disabling the IO chain.
>
>>>> During idle, if the PER powerdomain transitions and CORE does not (as
>
>>>   Does not what?
>
>> How about ".. and CORE does not transition"?
>
>    Transition to what then? Sentense till won't parse right...
>
>> Kevin, care to clarify that?
>
>    Yeah, looks like a considerable partt of that sentense got omitted...
>

No.  Nothing was omitted.  

It's like saying "Tony drinks Fernet and Kevin does not."  Adding an
additional "drinks Fernet" at the end is redundant.

Kevin
