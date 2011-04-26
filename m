From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 26 Apr 2011 21:33:06 +0100
Subject: [PATCH 1/6] dmaengine/dw_dmac: Replace spin_lock_bh with
	irqsave variants
In-Reply-To: <4DAD2AE9.7060106@st.com>
References: <e52c8e679fbf3007cf7e5e4bcfc86ea208a09d7c.1303123511.git.viresh.kumar@st.com>
	<4DAD2AE9.7060106@st.com>
Message-ID: <20110426203306.GC17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2011 at 11:55:45AM +0530, viresh kumar wrote:
> This must have been added in dw_dma_chan instead :(
> Will resend it.

Even that doesn't work.  It has to be a local variable.
