From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 19 Aug 2011 10:00:15 +0100
Subject: [PATCH v2 0/3] Fix Thumb-2 undef handling for mixed-arch kernels
In-Reply-To: <20110818222906.GD28546@n2100.arm.linux.org.uk>
References: <1313686914-29481-1-git-send-email-dave.martin@linaro.org>
	<20110818222906.GD28546@n2100.arm.linux.org.uk>
Message-ID: <20110819090015.GB2046@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 18, 2011 at 11:29:06PM +0100, Russell King - ARM Linux wrote:
> On Thu, Aug 18, 2011 at 06:01:51PM +0100, Dave Martin wrote:
> > In kernels which support v6 and v7 platforms in a single binary
> > such as omap2plus_defconfig for example, undefined instruction
> > exceptions taken on Thumb instructions are not processed correctly,
> > because the kernel assumes at build-time that Thumb-2 won't be
> > supported in userspace.
> 
> Unless there's any further comments from anyone, I think this is now
> ready.  Thanks.

OK, I'll send it to the patch system if nobody comes back with anything.

Cheers
---Dave
