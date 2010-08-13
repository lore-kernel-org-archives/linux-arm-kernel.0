From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 13 Aug 2010 14:50:53 +0400
Subject: [PATCH 3/6] OMAP3: PM: ensure IO wakeups are properly disabled
In-Reply-To: <20100813102933.GN12706@atomide.com>
References: <20100813080034.18750.15410.stgit@baageli.muru.com>
	<20100813080200.18750.37791.stgit@baageli.muru.com>
	<4C651635.8000201@ru.mvista.com>
	<20100813102933.GN12706@atomide.com>
Message-ID: <4C65238D.9080105@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Tony Lindgren wrote:

>>> From: Kevin Hilman <khilman@ti.com>
>>> Commit 5a5f561 (convert OMAP3 PRCM macros to the _SHIFT/_MASK suffixes)
>>> mistakenly removed the check for PER when disabling the IO chain.

>>> During idle, if the PER powerdomain transitions and CORE does not (as

>>   Does not what?

> How about ".. and CORE does not transition"?

    Transition to what then? Sentense till won't parse right...

> Kevin, care to clarify that?

    Yeah, looks like a considerable partt of that sentense got omitted...

> Tony

WBR, Sergei
