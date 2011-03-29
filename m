From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 29 Mar 2011 08:53:11 +0100
Subject: [PATCH 2/2] regulator: Propagate uA_load requirements up supply
	chain
In-Reply-To: <20110328181415.GD31457@n2100.arm.linux.org.uk>
References: <1301326482-6547-1-git-send-email-collinsd@codeaurora.org>
	<1301326482-6547-3-git-send-email-collinsd@codeaurora.org>
	<20110328180255.GA28494@opensource.wolfsonmicro.com>
	<20110328181415.GD31457@n2100.arm.linux.org.uk>
Message-ID: <20110329075310.GA29330@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 28, 2011 at 07:14:15PM +0100, Russell King - ARM Linux wrote:

> That's not true.  Firstly, *all* regulators are not 100% efficient.  They
> lose *power* in the form of heat.  So power into the regulator will always
> be more than power out.

That's pretty much what I said, yes.
