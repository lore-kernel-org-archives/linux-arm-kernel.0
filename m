From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 26 Apr 2012 10:49:02 +0100
Subject: [PATCH] clk: Use a separate struct for holding init data.
In-Reply-To: <20120426083924.GE17184@pengutronix.de>
References: <1335419936-10881-1-git-send-email-skannan@codeaurora.org>
 <20120426083924.GE17184@pengutronix.de>
Message-ID: <20120426094901.GE3207@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2012 at 10:39:24AM +0200, Sascha Hauer wrote:

> Can we please stop messing with the function prototypes? So you prefer
> passing a struct to clk_register which is fine and yes, it may have
> advantages. But do we really need to change the prototype? Why can't we
> just add a new function?

> I am generally open to do these changes, but we have come to the point
> where people actually want to *use* the clock framework instead of
> rebasing their stuff onto the latest patches.

Or at least wait until we've got somewhere with applying drivers so that
whoever is changing the APIs is responsible for updating at least the
in-tree drivers.  This would minimise the pain for people who've been
sitting waiting to get their stuff in which seems helpful.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120426/17d8c96e/attachment.sig>
