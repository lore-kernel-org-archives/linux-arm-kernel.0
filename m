From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 20 May 2015 08:57:36 +0200
Subject: [RFC] arm: Add for atomic half word exchange
In-Reply-To: <1348896100.440561432098574765.JavaMail.weblogic@ep2mlwas07a>
References: <1348896100.440561432098574765.JavaMail.weblogic@ep2mlwas07a>
Message-ID: <20150520065736.GI3644@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 20, 2015 at 05:09:34AM +0000, Sarbojit Ganguly wrote:
> Yes, the main advantage of Qspinlock code can be observed in NUMA but
> when I tested in an embedded system, a slight advantage was observed.

OK, great!

This is the first !x86 port I'm aware of and a load-store arch at that,
so its good to hear our efforts at making it generic actually paid off.
