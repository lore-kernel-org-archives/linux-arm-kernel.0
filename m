From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 20 Oct 2011 12:27:24 +0100
Subject: [GIT PULL] genirq support for GIC PPIs
In-Reply-To: <4E9FF695.10604@arm.com>
References: <4E9FF695.10604@arm.com>
Message-ID: <20111020112724.GZ21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2011 at 11:23:17AM +0100, Marc Zyngier wrote:
> The following changes since commit 5a567d78c437e3be1c512734cdfe64b4ae6b82d7:
>   Jamie Iles (1):
>         ARM: 7115/4: move __exception and friends to asm/exception.h
> 
> are available in the git repository at:
> 
>   git://github.com/mzyngier/arm-platforms.git ppi-for-rmk
> 
> Marc Zyngier (4):
>       genirq: Add support for per-cpu dev_id interrupts
>       genirq: percpu: allow interrupt type to be set at enable time
>       ARM: gic: consolidate PPI handling
>       ARM: gic, local timers: use the request_percpu_irq() interface
> 
> Thomas Gleixner (1):
>       genirq: Fix fatfinered fixup really

I thought you said some of these were in Thomas' tree already?
