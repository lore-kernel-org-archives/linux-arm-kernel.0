From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 21 Jun 2010 15:22:29 -0700
Subject: [RFC PATCH] smp: parallel smp boot option
In-Reply-To: <20100621220030.GC13624@n2100.arm.linux.org.uk>
References: <1277156422-9130-1-git-send-email-dwalker@codeaurora.org>
	<20100621220030.GC13624@n2100.arm.linux.org.uk>
Message-ID: <1277158949.17092.61.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-06-21 at 23:00 +0100, Russell King - ARM Linux wrote:
> On Mon, Jun 21, 2010 at 02:40:22PM -0700, Daniel Walker wrote:
> > +#ifdef CONFIG_SMP_PARALLEL_START
> > +	bl	__smp_secondary_spin
> > +#endif
> 

Your OK with this hook? I was thinking it might be better to check if
it's the book cpu or the secondary here instead of in
arch/arm/mach-msm .

Steve, do you have any thoughts on that?

Daniel


-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
