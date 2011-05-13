From: jmorris@namei.org (James Morris)
Date: Fri, 13 May 2011 10:18:52 +1000 (EST)
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
In-Reply-To: <20110512130104.GA2912@elte.hu>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
	<1305169376-2363-1-git-send-email-wad@chromium.org>
	<20110512074850.GA9937@elte.hu>
	<alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
	<20110512130104.GA2912@elte.hu>
Message-ID: <alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 12 May 2011, Ingo Molnar wrote:
> Funnily enough, back then you wrote this:
> 
>   " I'm concerned that we're seeing yet another security scheme being designed on 
>     the fly, without a well-formed threat model, and without taking into account 
>     lessons learned from the seemingly endless parade of similar, failed schemes. "
> 
> so when and how did your opinion of this scheme turn from it being an "endless 
> parade of failed schemes" to it being a "well-defined and readily 
> understandable feature"? :-)

When it was defined in a way which limited its purpose to reducing the 
attack surface of the sycall interface.


- James
-- 
James Morris
<jmorris@namei.org>
