From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 2 Nov 2017 18:46:28 +0100
Subject: [PATCH] arm: ensure dump_instr() checks addr_limit
In-Reply-To: <20171102173003.t5wugpup26eu2hpx@lakrids.cambridge.arm.com>
References: <20171102163452.7652-1-mark.rutland@arm.com>
 <20171102164706.GC5061@kroah.com>
 <20171102173003.t5wugpup26eu2hpx@lakrids.cambridge.arm.com>
Message-ID: <20171102174628.GC27444@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 02, 2017 at 05:30:04PM +0000, Mark Rutland wrote:
> On Thu, Nov 02, 2017 at 05:47:06PM +0100, Greg KH wrote:
> > On Thu, Nov 02, 2017 at 04:34:52PM +0000, Mark Rutland wrote:
> > > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > 
> > Huh?  What's that doing up here?
> 
> [...]
> 
> > > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Russell King <rmk+kernel@armlinux.org.uk>
> > > Cc: stable at vger.kernel.org
> > 
> > It's right here...
> 
> Sorry; I'd generated this commit message from another. I must've
> accidentally passed -s to git commit before copying the text I wanted.
> 
> I will be more careful in future, and I'll remove the first instance
> if/when submitting this to Russell's patch system.

Russell's patch system?  That's still in use and required?  Ugh, that's
crazy...

Anyway, thanks for fixing it up.

greg k-h
