From: mbizon@freebox.fr (Maxime Bizon)
Date: Thu, 12 Dec 2013 23:44:05 +0100
Subject: gcc miscompiles csum_tcpudp_magic() on ARMv5
In-Reply-To: <20131212223626.GW4360@n2100.arm.linux.org.uk>
References: <1386850444.22947.46.camel@sakura.staff.proxad.net>
 <20131212124015.GL4360@n2100.arm.linux.org.uk>
 <1386855390.22947.68.camel@sakura.staff.proxad.net>
 <20131212144853.GO4360@n2100.arm.linux.org.uk>
 <1386860657.25449.3.camel@sakura.staff.proxad.net>
 <20131212154110.GQ4360@n2100.arm.linux.org.uk>
 <20131212160426.GD31816@1wt.eu>
 <20131212164748.GS4360@n2100.arm.linux.org.uk>
 <1386887402.25449.48.camel@sakura.staff.proxad.net>
 <20131212223626.GW4360@n2100.arm.linux.org.uk>
Message-ID: <1386888245.25449.51.camel@sakura.staff.proxad.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Thu, 2013-12-12 at 22:36 +0000, Russell King - ARM Linux wrote:

> Does this bug show up in existing unmodified mainline kernels?

not for me, I found this while writing new code.

though all possible kernel callers are not enabled in my .config.

-- 
Maxime
