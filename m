From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 24 Feb 2010 08:31:43 +0000
Subject: PL-330 DMA driver
In-Reply-To: <20100224004422.GD30679@trinity.fluff.org>
References: <1b68c6791002162150wb8fbae8ya1e5b3c0a56b7fad@mail.gmail.com>
	<e9c3a7c21002172224y7a80d913r5b78c1e41a91565f@mail.gmail.com>
	<20100218103203.GB20243@n2100.arm.linux.org.uk>
	<20100224004422.GD30679@trinity.fluff.org>
Message-ID: <20100224083143.GA6723@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 24, 2010 at 12:44:22AM +0000, Ben Dooks wrote:
> Which is great, until you find out that the S3C PL080 isn't a vanilla
> PL080, and has extra registers.

We're not going to go hacking drivers to have multiple different DMA
interfaces inside them just because SoC maintainers want their own
private DMA interfaces.  We need to come up with a better solution to
this problem.

As I've said, the reality is that ARM's primecell IP is starting to
appear in multiple different SoCs, so we need to solve this problem
now.
