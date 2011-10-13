From: premi@ti.com (Premi, Sanjeev)
Date: Thu, 13 Oct 2011 20:36:19 +0530
Subject: [PATCH] arm: omap: Fix errors and warnings when building for
	one board
In-Reply-To: <20111013145615.GB22076@n2100.arm.linux.org.uk>
References: <1318517623-16066-1-git-send-email-premi@ti.com>
	<20111013145615.GB22076@n2100.arm.linux.org.uk>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930257A57F4E@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk] 
> Sent: Thursday, October 13, 2011 8:26 PM
> To: Premi, Sanjeev
> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] arm: omap: Fix errors and warnings when 
> building for one board
> 
> On Thu, Oct 13, 2011 at 08:23:43PM +0530, Sanjeev Premi wrote:
> > +#if defined(CONFIG_ARCH_OMAP4)
> 
> Please use #ifdef unless you're intending to expand the condition.
> 

I tried to be consistent with existing use of #if defined() in the
file(s). Will change it.

Should I change the other instances as well?

~sanjeev
