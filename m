From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 20 Dec 2010 13:46:11 -0500 (EST)
Subject: [PATCH] hvc_dcc: Simplify assembly for v6 and v7 ARM
In-Reply-To: <4D0FA2EE.90703@codeaurora.org>
References: <20101201192856.GA731@suse.de>
	<1292649385-28771-1-git-send-email-sboyd@codeaurora.org>
	<1292867461.27552.15.camel@m0nster> <4D0FA2EE.90703@codeaurora.org>
Message-ID: <alpine.LFD.2.00.1012201344580.10437@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 Dec 2010, Stephen Boyd wrote:

> On 12/20/2010 09:51 AM, Daniel Walker wrote:
> >
> > I would expect to see three patches. One that adds volatile, which
> > appears to be a good fix. Another patch that changes the assembly lines,
> > and another that does the clean up. The last two are more controversial
> > ones
> 
> Ok. I'll send a series later today to give some more time for feedback.

I think you can do that right away.  Splitting the patch will make that 
feedback easier to provide.


Nicolas
