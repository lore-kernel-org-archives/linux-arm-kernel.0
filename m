From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 8 Mar 2012 12:46:59 +0100 (CET)
Subject: Regression in 3.2.9 for omap-serial (at least)
In-Reply-To: <lyk42vxsz2.fsf@ensc-virt.intern.sigma-chemnitz.de>
References: <lyk42vxsz2.fsf@ensc-virt.intern.sigma-chemnitz.de>
Message-ID: <alpine.LFD.2.02.1203081246130.2742@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 8 Mar 2012, Enrico Scholz wrote:
> Hi,
> 
> the commit "genirq: Unmask oneshot irqs when thread was not woken"[1]
> breaks at least the omap-serial driver which requests a shared interrupt

Fixed with 52abb700e16a9a

Thanks,

	tglx
