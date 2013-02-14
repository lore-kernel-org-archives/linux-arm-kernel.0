From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 14 Feb 2013 14:37:52 +0000
Subject: i.MX6 Solo: maxcpus=1 vs. nosmp: Warning from smp_twd.c?
In-Reply-To: <511CF063.3010200@de.bosch.com>
References: <511CF063.3010200@de.bosch.com>
Message-ID: <20130214143752.GH17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 14, 2013 at 03:10:43PM +0100, Dirk Behme wrote:
> working on a i.MX6 Solo SoC (one Cortex A9 core) we are usually booting  
> with maxcpus=1 a kernel built with CONFIG_NR_CPUS=4. This is done to be  
> able to boot the same kernel on the Solo and Quad version of that SoC.

And what happens if you compile a kernel without SMP support and boot
it on this SoC?
