From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 30 Jan 2014 17:52:58 +0100
Subject: [PATCH v2 6/6] cpu/idle.c: move to sched/idle.c
In-Reply-To: <1391100076.2422.56.camel@joe-AO722>
References: <1391017513-12995-1-git-send-email-nicolas.pitre@linaro.org>
 <1391017513-12995-7-git-send-email-nicolas.pitre@linaro.org>
 <20140130152500.GB5002@laptop.programming.kicks-ass.net>
 <alpine.LFD.2.11.1401301102210.1652@knanqh.ubzr>
 <20140130162753.GF5002@laptop.programming.kicks-ass.net>
 <1391100076.2422.56.camel@joe-AO722>
Message-ID: <20140130165258.GC2936@laptop.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 30, 2014 at 08:41:16AM -0800, Joe Perches wrote:
> Perhaps you could use a newer version of patch
> 
> GNU patch version 2.7 released

Yeah, I know about that, I'll wait until its common in all distros,
updating all machines I use by hand is just painful.
