From: jmorris@namei.org (James Morris)
Date: Tue, 17 May 2011 23:29:36 +1000 (EST)
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
In-Reply-To: <20110517131058.GE21441@elte.hu>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
	<1305169376-2363-1-git-send-email-wad@chromium.org>
	<20110512074850.GA9937@elte.hu>
	<alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
	<20110512130104.GA2912@elte.hu>
	<alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
	<20110513121034.GG21022@elte.hu>
	<alpine.LRH.2.00.1105161006340.21749@tundra.namei.org>
	<20110516150837.GA513@elte.hu>
	<alpine.LRH.2.00.1105171214330.31710@tundra.namei.org>
	<20110517131058.GE21441@elte.hu>
Message-ID: <alpine.LRH.2.00.1105172317060.5404@tundra.namei.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 May 2011, Ingo Molnar wrote:

> I'm not sure i get your point.

Your example was not complete as described.  After an apparently simple 
specification, you've since added several qualifiers and assumptions, and 
I still doubt that it's complete.

A higher level goal would look like

"Allow a sandbox app access only to approved resources, to contain the 
effects of flaws in the app", or similar.

Note that this includes a threat model (remote attacker taking control of 
the app) and a general and fully stated strategy for dealing with it.
