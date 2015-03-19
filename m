From: rostedt@goodmis.org (Steven Rostedt)
Date: Thu, 19 Mar 2015 15:01:11 -0400
Subject: [RFC PATCH 2/7] printk: Simple implementation for NMI backtracing
In-Reply-To: <550B19EA.6000202@linaro.org>
References: <1426688428-3150-1-git-send-email-daniel.thompson@linaro.org>
 <1426688428-3150-3-git-send-email-daniel.thompson@linaro.org>
 <20150319133958.4821493e@gandalf.local.home>
 <20150319183037.GT23123@twins.programming.kicks-ass.net>
 <550B19EA.6000202@linaro.org>
Message-ID: <20150319150111.778d21d3@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Mar 2015 18:48:10 +0000
Daniel Thompson <daniel.thompson@linaro.org> wrote:
\
> The barrier was not intended to have anything to do with put_cpu() 
> either though since the barrier was added before put_cpu() arrived:
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=554ec063982752e9a569ab9189eeffa3d96731b2
> 
> There's nothing in the commit comment explaining the barrier and I 
> really can't see what it is for.
> 

Looks like it wasn't needed then either.

-- Steve
