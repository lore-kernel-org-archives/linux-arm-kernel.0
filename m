From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 16 Jul 2015 13:07:12 +0200 (CEST)
Subject: [PATCH 1/3] nmi: create generic NMI backtrace implementation
In-Reply-To: <E1ZFTSm-0006uz-3s@rmk-PC.arm.linux.org.uk>
References: <20150715203911.GF7557@n2100.arm.linux.org.uk>
 <E1ZFTSm-0006uz-3s@rmk-PC.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.11.1507161306580.18576@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 15 Jul 2015, Russell King wrote:

> x86s NMI backtrace implementation (for arch_trigger_all_cpu_backtrace())
> is fairly generic in nature - the only architecture specific bits are
> the act of raising the NMI to other CPUs, and reporting the status of
> the NMI handler.
> 
> These are fairly simple to factor out, and produce a generic
> implementation which can be shared between ARM and x86.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
