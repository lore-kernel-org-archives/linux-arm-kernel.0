From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 2 Nov 2017 17:30:04 +0000
Subject: [PATCH] arm: ensure dump_instr() checks addr_limit
In-Reply-To: <20171102164706.GC5061@kroah.com>
References: <20171102163452.7652-1-mark.rutland@arm.com>
 <20171102164706.GC5061@kroah.com>
Message-ID: <20171102173003.t5wugpup26eu2hpx@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 02, 2017 at 05:47:06PM +0100, Greg KH wrote:
> On Thu, Nov 02, 2017 at 04:34:52PM +0000, Mark Rutland wrote:
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> 
> Huh?  What's that doing up here?

[...]

> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Russell King <rmk+kernel@armlinux.org.uk>
> > Cc: stable at vger.kernel.org
> 
> It's right here...

Sorry; I'd generated this commit message from another. I must've
accidentally passed -s to git commit before copying the text I wanted.

I will be more careful in future, and I'll remove the first instance
if/when submitting this to Russell's patch system.

Thanks,
Mark.
