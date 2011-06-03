From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 3 Jun 2011 11:57:23 -0600
Subject: [PATCH v2 0/2] Move Freescale MXS gpio driver into drivers/gpio
In-Reply-To: <20110530064502.GC23771@pengutronix.de>
References: <1306595374-25178-1-git-send-email-shawn.guo@linaro.org>
	<20110530064502.GC23771@pengutronix.de>
Message-ID: <20110603175723.GE15616@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 30, 2011 at 08:45:02AM +0200, Sascha Hauer wrote:
> Grant,
> 
> I suppose we should take this through the architecture tree. Can I have
> your Ack for this?
> 

Actually, as mentioned in my other email, I'd like to see this series
respun with a separate patch for just moving the gpio driver (without
breaking the build).  

Also, I've been thinking about how to merge these changes, and I'd
rather take them through the gpio tree since there will be a lot of
conflicts with the other gpio driver moves.  It will be easier to
resolve merge conflicts if I push it out to my tree and allow the
subarch trees to merge in mine if necessary.

g.
