From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 Mar 2011 09:28:48 +0100
Subject: [PATCH 2/2] regulator: Propagate uA_load requirements up
	supply chain
In-Reply-To: <20110329075310.GA29330@opensource.wolfsonmicro.com>
References: <1301326482-6547-1-git-send-email-collinsd@codeaurora.org>
	<1301326482-6547-3-git-send-email-collinsd@codeaurora.org>
	<20110328180255.GA28494@opensource.wolfsonmicro.com>
	<20110328181415.GD31457@n2100.arm.linux.org.uk>
	<20110329075310.GA29330@opensource.wolfsonmicro.com>
Message-ID: <20110329082848.GA10447@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 29, 2011 at 08:53:11AM +0100, Mark Brown wrote:
> On Mon, Mar 28, 2011 at 07:14:15PM +0100, Russell King - ARM Linux wrote:
> 
> > That's not true.  Firstly, *all* regulators are not 100% efficient.  They
> > lose *power* in the form of heat.  So power into the regulator will always
> > be more than power out.
> 
> That's pretty much what I said, yes.

No, you said the power will map through but the current will not.  I'm
saying that the power will *not* map through either.
