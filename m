From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 13 Aug 2010 13:53:57 +0400
Subject: [PATCH 3/6] OMAP3: PM: ensure IO wakeups are properly disabled
In-Reply-To: <20100813080200.18750.37791.stgit@baageli.muru.com>
References: <20100813080034.18750.15410.stgit@baageli.muru.com>
	<20100813080200.18750.37791.stgit@baageli.muru.com>
Message-ID: <4C651635.8000201@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Tony Lindgren wrote:

> From: Kevin Hilman <khilman@ti.com>

> Commit 5a5f561 (convert OMAP3 PRCM macros to the _SHIFT/_MASK suffixes)
> mistakenly removed the check for PER when disabling the IO chain.
> 
> During idle, if the PER powerdomain transitions and CORE does not (as

   Does not what?

> is the case with the lower C-states when using CPUidle) the IO pad
> wakeups are not being disabled in the idle path after they are
> enabled.

WBR, Sergei
