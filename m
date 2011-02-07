From: tony@atomide.com (Tony Lindgren)
Date: Mon, 7 Feb 2011 08:12:57 -0800
Subject: [RFC 3/5] ARM: P2V: make head.S use PLAT_PHYS_OFFSET
In-Reply-To: <alpine.LFD.2.00.1101041612480.22191@xanadu.home>
References: <20110104202052.GE24935@n2100.arm.linux.org.uk>
	<E1PaDPF-00023h-V5@rmk-PC.arm.linux.org.uk>
	<alpine.LFD.2.00.1101041612480.22191@xanadu.home>
Message-ID: <20110207161257.GG20795@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolas Pitre <nico@fluxnic.net> [110104 13:32]:
> On Tue, 4 Jan 2011, Russell King - ARM Linux wrote:
> 
> > head.S makes use of PHYS_OFFSET.  When it becomes a variable, the
> > assembler won't understand this.  Switch it to use PLAT_PHYS_OFFSET
> > for the time being, until this code is properly updated.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Right...  One thing at a time.
> 
> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

With the omap DEBUG_LL fix the version of this in the p2v
branch works for omaps:

Tested-by: Tony Lindgren <tony@atomide.com>
