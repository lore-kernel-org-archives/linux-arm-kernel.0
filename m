From: jmorris@namei.org (James Morris)
Date: Tue, 17 May 2011 12:24:34 +1000 (EST)
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
In-Reply-To: <20110516150837.GA513@elte.hu>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
	<1305169376-2363-1-git-send-email-wad@chromium.org>
	<20110512074850.GA9937@elte.hu>
	<alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
	<20110512130104.GA2912@elte.hu>
	<alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
	<20110513121034.GG21022@elte.hu>
	<alpine.LRH.2.00.1105161006340.21749@tundra.namei.org>
	<20110516150837.GA513@elte.hu>
Message-ID: <alpine.LRH.2.00.1105171214330.31710@tundra.namei.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 16 May 2011, Ingo Molnar wrote:

> > Not really.
> > 
> > Firstly, what is the security goal of these restrictions? [...]
> 
> To do what i described above? Namely:
> 
>  " Sandboxed code should only be allowed to open files in /home/sandbox/, /lib/
>    and /usr/lib/ "

These are access rules, they don't really describe a high-level security 
goal.  How do you know it's ok to open everything in these directories?


- James
-- 
James Morris
<jmorris@namei.org>
