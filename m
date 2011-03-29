From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 29 Mar 2011 17:40:10 +0900
Subject: [PATCH 2/2] regulator: Propagate uA_load requirements up supply
	chain
In-Reply-To: <20110329082848.GA10447@n2100.arm.linux.org.uk>
References: <1301326482-6547-1-git-send-email-collinsd@codeaurora.org>
	<1301326482-6547-3-git-send-email-collinsd@codeaurora.org>
	<20110328180255.GA28494@opensource.wolfsonmicro.com>
	<20110328181415.GD31457@n2100.arm.linux.org.uk>
	<20110329075310.GA29330@opensource.wolfsonmicro.com>
	<20110329082848.GA10447@n2100.arm.linux.org.uk>
Message-ID: <20110329084009.GA29874@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 29, 2011 at 09:28:48AM +0100, Russell King - ARM Linux wrote:
> On Tue, Mar 29, 2011 at 08:53:11AM +0100, Mark Brown wrote:

> > That's pretty much what I said, yes.

> No, you said the power will map through but the current will not.  I'm
> saying that the power will *not* map through either.

I said that even with a perfectly efficient regulator the current won't
map through, and that physical regulators make things even less direct.
