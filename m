From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 13 May 2011 15:55:36 +0200
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system
	call filtering
In-Reply-To: <20110513124902.GC3924@elte.hu>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
	<1305169376-2363-1-git-send-email-wad@chromium.org>
	<20110512074850.GA9937@elte.hu>
	<alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
	<20110512130104.GA2912@elte.hu>
	<alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
	<20110513121034.GG21022@elte.hu> <1305289146.2466.8.camel@twins>
	<20110513122646.GA3924@elte.hu> <1305290370.2466.14.camel@twins>
	<20110513124902.GC3924@elte.hu>
Message-ID: <1305294936.2466.65.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-05-13 at 14:49 +0200, Ingo Molnar wrote:
> 
> So given that by your own admission it makes sense to share the facilities at 
> the low level, i also argue that it makes sense to share as high up as 
> possible. 

I'm not saying any such thing, I'm saying that it might make sense to
observe active objects and auto-create these observation points. That
doesn't make them similar or make them share anything.
