From: marc@cpdesign.com.au (Marc Reilly)
Date: Tue, 5 Oct 2010 16:06:24 +1100
Subject: I.MX35 GPIO IRQ + Preempt -> Oops
In-Reply-To: <4CA9C384.2070208@eukrea.com>
References: <4CA739B4.1020506@eukrea.com> <4CA98B8C.4010106@eukrea.com>
	<4CA9C384.2070208@eukrea.com>
Message-ID: <201010051606.24617.marc@cpdesign.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

For what it's worth...

> Also : same problem with Freescale's BSP (2.6.31 based) and same "fix"
> (removing the WFI).

My kernel won't even boot up (although I don't usually get a kernel oops, only 
very occasionally) unless i pass the jtag=on parameter (or nohlt for non 
freescale kernel). It just freezes.

I think both of those workarounds effectively bypass the cpu_do_idle() call. 

Its new hardware for me, so I haven't delved into it more than that.

Cheers
Marc
