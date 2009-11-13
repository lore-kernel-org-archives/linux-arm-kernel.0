From: simon.kagstrom@netinsight.net (Simon Kagstrom)
Date: Fri, 13 Nov 2009 11:08:18 +0100
Subject: [PATCH] serial21285: fix disable_irq-from-interrupt-handler
	deadlock
In-Reply-To: <20091113095937.GA25995@n2100.arm.linux.org.uk>
References: <20091113090234.7d028820@marrow.netinsight.se>
	<20091113095937.GA25995@n2100.arm.linux.org.uk>
Message-ID: <20091113110818.26c0a091@marrow.netinsight.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 13 Nov 2009 09:59:37 +0000
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Fri, Nov 13, 2009 at 09:02:34AM +0100, Simon Kagstrom wrote:
> > Russell: This patch is a bit of RFC since I'm not quite sure that it's
> > the correct solution. It unbreaks booting on our footbridge-based
> > platform. Let me know if I should look at other solutions!
> 
> It does look like the right thing to do - the original code will hang
> now that we're using genirq stuff.

Good, thanks. I guess you'll take it into your tree then?

// Simon
