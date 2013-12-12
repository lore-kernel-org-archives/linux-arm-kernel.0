From: mbizon@freebox.fr (Maxime Bizon)
Date: Thu, 12 Dec 2013 23:30:02 +0100
Subject: gcc miscompiles csum_tcpudp_magic() on ARMv5
In-Reply-To: <20131212164748.GS4360@n2100.arm.linux.org.uk>
References: <1386850444.22947.46.camel@sakura.staff.proxad.net>
 <20131212124015.GL4360@n2100.arm.linux.org.uk>
 <1386855390.22947.68.camel@sakura.staff.proxad.net>
 <20131212144853.GO4360@n2100.arm.linux.org.uk>
 <1386860657.25449.3.camel@sakura.staff.proxad.net>
 <20131212154110.GQ4360@n2100.arm.linux.org.uk>
 <20131212160426.GD31816@1wt.eu>
 <20131212164748.GS4360@n2100.arm.linux.org.uk>
Message-ID: <1386887402.25449.48.camel@sakura.staff.proxad.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Thu, 2013-12-12 at 16:47 +0000, Russell King - ARM Linux wrote:
> 
> So here's a patch for Maxime to try - I've not run it yet but it seems
> to do the right thing by code inspection. 

Kernel built with this patch seems to work fine. Also I called it
manually with a few test patterns and the results are correct.

Tested-by: Maxime Bizon <mbizon@freebox.fr>

Thanks Russell,

-- 
Maxime
