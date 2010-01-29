From: dwalker@codeaurora.org (Daniel Walker)
Date: Fri, 29 Jan 2010 11:12:18 -0800
Subject: [RFC PATCH 04/12] arm: mm: cache-l2x0: add l2x0 suspend and
	resume functions
In-Reply-To: <20100129190355.GA19882@n2100.arm.linux.org.uk>
References: <1264719577-5436-5-git-send-email-dwalker@codeaurora.org>
	<1264763312.4242.47.camel@pc1117.cambridge.arm.com>
	<179C5F34D68DF54C8898E904FC5BAF8C79E15B77C4@NALASEXMB09.na.qualcomm.com>
	<1264787969.1818.6.camel@c-dwalke-linux.qualcomm.com>
	<179C5F34D68DF54C8898E904FC5BAF8C79E15B77CD@NALASEXMB09.na.qualcomm.com>
	<1264789772.1818.8.camel@c-dwalke-linux.qualcomm.com>
	<20100129190355.GA19882@n2100.arm.linux.org.uk>
Message-ID: <1264792338.1818.28.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-01-29 at 19:03 +0000, Russell King - ARM Linux wrote:

> > 
> > Maybe cache_sync was recently changed to "writel" instead sync_writel()
> > due it getting called with the lock already held.
> 
> It's pointless discussing what the current code does, because that's
> not what mainline does _today_ - the locking in this file has
> completely changed.

Where is the code we should be looking at (what I quoted is from -next)?
Or is it in -next and we just need to look closer ? 

Daniel
