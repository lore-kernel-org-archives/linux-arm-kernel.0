From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 18 Aug 2016 11:47:16 +0100
Subject: [PATCH] arm: remove traces of perf_ops_bp
In-Reply-To: <20160815094649.GA13262@arm.com>
References: <1470934766-4009-1-git-send-email-mark.rutland@arm.com>
 <20160815094649.GA13262@arm.com>
Message-ID: <20160818104716.GD27045@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 15, 2016 at 10:46:50AM +0100, Will Deacon wrote:
> On Thu, Aug 11, 2016 at 05:59:26PM +0100, Mark Rutland wrote:
> > Even though perf_ops_bp was removed/renamed back in commit
> > b0a873ebbf87bf38 ("perf: Register PMU implementations"), as part of
> > v2.6.37, its definition still lives on in some arch headers.
> > 
> > This patch removes the vestigal definition from arm.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm/include/asm/hw_breakpoint.h | 1 -
> >  1 file changed, 1 deletion(-)
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Please put this into the patch system -- I'll pick the other one up for
> arm64.

Cheers.

I've dropped this in the patch system as 8598/1.

Mark.
