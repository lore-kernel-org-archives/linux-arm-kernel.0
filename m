From: nico@fluxnic.net (Nicolas Pitre)
Date: Sat, 12 Feb 2011 16:01:14 -0500 (EST)
Subject: The p2v branch
In-Reply-To: <20110212184138.GD22402@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1102121304500.14920@xanadu.home>
	<20110212184138.GD22402@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1102121556330.14920@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 12 Feb 2011, Russell King - ARM Linux wrote:

> On Sat, Feb 12, 2011 at 01:32:48PM -0500, Nicolas Pitre wrote:
> 
> > 3ecf8ba5 ARM: P2V: eliminate head.S use of PHYS_OFFSET for !XIP_KERNEL
> > Reviewed-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> > 
> > 5e8e98cd ARM: P2V: introduce phys_to_virt/virt_to_phys runtime patching
> > Reviewed-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> > Tested-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> > 
> > 1929d11e ARM: P2V: extend to 16-bit translation offsets
> > Reviewed-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> > Tested-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> > (forced it on with non-msm targets for testing)
> > 
> > b7a0fbb4 ARM: 6648/1: map ATAGs when not in first 1MB of RAM
> > Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> Added.

I've rebased my 2 patches on top of your latest p2v branch.  You may 
pull them from:

	git://git.linaro.org/people/nico/linux p2v

Or if you prefer I can put them in the patch system.


Nicolas
