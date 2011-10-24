From: tj@kernel.org (Tejun Heo)
Date: Mon, 24 Oct 2011 08:44:39 -0700
Subject: [RFC 3/4] lib: devres: add convenience function to remap a
	resource
In-Reply-To: <20111024115612.GL8708@ponder.secretlab.ca>
References: <1319445729-14841-1-git-send-email-w.sang@pengutronix.de>
	<1319445729-14841-4-git-send-email-w.sang@pengutronix.de>
	<20111024115612.GL8708@ponder.secretlab.ca>
Message-ID: <20111024154439.GC24914@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, Grant.

On Mon, Oct 24, 2011 at 01:56:12PM +0200, Grant Likely wrote:
> > +/**
> > + * devm_resource_to_mapped_ptr - Check, request region, and ioremap resource
> 
> Kernel doc format should have '()' for functions is:

Simple Grepping gives me an order of magnitude more on the ones w/o
'()'.  Maybe it's better to change the rule at this point?

Thanks.

-- 
tejun
