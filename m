From: tony@atomide.com (Tony Lindgren)
Date: Fri, 13 Aug 2010 13:29:34 +0300
Subject: [PATCH 3/6] OMAP3: PM: ensure IO wakeups are properly disabled
In-Reply-To: <4C651635.8000201@ru.mvista.com>
References: <20100813080034.18750.15410.stgit@baageli.muru.com>
	<20100813080200.18750.37791.stgit@baageli.muru.com>
	<4C651635.8000201@ru.mvista.com>
Message-ID: <20100813102933.GN12706@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sergei Shtylyov <sshtylyov@mvista.com> [100813 12:48]:
> Hello.
> 
> Tony Lindgren wrote:
> 
> >From: Kevin Hilman <khilman@ti.com>
> 
> >Commit 5a5f561 (convert OMAP3 PRCM macros to the _SHIFT/_MASK suffixes)
> >mistakenly removed the check for PER when disabling the IO chain.
> >
> >During idle, if the PER powerdomain transitions and CORE does not (as
> 
>   Does not what?

How about ".. and CORE does not transition"?

Kevin, care to clarify that?

Tony
