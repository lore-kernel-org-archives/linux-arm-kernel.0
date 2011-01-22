From: nico@fluxnic.net (Nicolas Pitre)
Date: Sat, 22 Jan 2011 14:49:33 -0500 (EST)
Subject: [PATCH 0/7] Nexus One Support
In-Reply-To: <AANLkTi=47z21zExtfHq2WYdUdXeC1rNhe7vQsqPkFsMi@mail.gmail.com>
References: <20110121094827.41818a55@jbarnes-desktop>
	<20110121095658.1ab623fe@jbarnes-desktop>
	<1295632828.19880.22.camel@m0nster>
	<20110121100441.06a94482@jbarnes-desktop>
	<1295633882.19880.31.camel@m0nster>
	<AANLkTi=L+MW5-KLP_TKSxhstD8JEtBW=RKci5wSbZsd6@mail.gmail.com>
	<1295642995.19880.42.camel@m0nster>
	<1295643762.25868.31.camel@Joe-Laptop>
	<1295645098.22882.1.camel@m0nster>
	<AANLkTi=mvdfpCPefGeDr+eGxpSUr3is5jgugHtgB-m1w@mail.gmail.com>
	<20110122122018.GC5194@n2100.arm.linux.org.uk>
	<AANLkTi=47z21zExtfHq2WYdUdXeC1rNhe7vQsqPkFsMi@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1101221432360.8580@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 22 Jan 2011, Brian Swetland wrote:

> All we ask is that some reasonable acknowledgement of original
> authorship is maintained for non-trivial work.  A 5-10 line patch that
> deals with mechanical issues of board files or cleans stuff up is no
> big deal.  100s of lines that represent some real work is something
> else.

So... What about http://article.gmane.org/gmane.linux.ports.arm.msm/167 ?
Is that good enough for you?  If no, then could you please propose an 
alternative?  If that is indeed good enough, then could we please move on?

> What would be useful would be a reasonable convention for
> acknowledging multiple authors, perhaps something along the lines of:
> 
> Author: Awesome Upstreamer <au@example.com>  or  Main Author <main@example.com>
> Committer: Awesome Upstreamer <au@example.com>
> Subject: arm: msm8k: acpu clock management
> 
> ... summary of the patch ...
> 
> Original-Author: Joe Firmware Guy <joe@oem.com>
> Original-Author: Kernel Droid <droid@android.com>
> Signed-off-by: ...
> 
> Though I'm not sure "Original-Author" is the best phrasing here...  Or
> perhaps just having the patch description end with "This patch is
> based on original code by Joe Firmware Guy, Kernel Droid, etc is the
> way to go.  I do think that for work where there is one clear original
> author, it's nice to leave them as the Author, but at the end of the
> day, provided the code's heading in the right direction and the
> contributors are acknowledged, that's a detail.

I think a free form list of contributors in the commit log should be 
fine, possibly adding them in CC to the patch submission as well.

There is a _huge_ value in the action of making code palatable for 
mainline inclusion and actually pushing that code into mainline. If you 
do it yourself next time instead of letting your code rot then no one 
might be tempted to stump on your authorship.


Nicolas
