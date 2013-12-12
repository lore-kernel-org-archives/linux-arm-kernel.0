From: mbizon@freebox.fr (Maxime Bizon)
Date: Thu, 12 Dec 2013 18:34:23 +0100
Subject: gcc miscompiles csum_tcpudp_magic() on ARMv5
In-Reply-To: <20131212154110.GQ4360@n2100.arm.linux.org.uk>
References: <1386850444.22947.46.camel@sakura.staff.proxad.net>
 <20131212124015.GL4360@n2100.arm.linux.org.uk>
 <1386855390.22947.68.camel@sakura.staff.proxad.net>
 <20131212144853.GO4360@n2100.arm.linux.org.uk>
 <1386860657.25449.3.camel@sakura.staff.proxad.net>
 <20131212154110.GQ4360@n2100.arm.linux.org.uk>
Message-ID: <1386869663.25449.15.camel@sakura.staff.proxad.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Thu, 2013-12-12 at 15:41 +0000, Russell King - ARM Linux wrote:
> 
> What's more, I've just had this confirmed by compiler people in ARM
> Ltd - we can't rely on the state of the upper 16 bits when passing a
> u16 into an asm().  So, it seems that it _is_ a kernel bug after all.
> 
ok, I was not crazy

thanks for the deeper analysis, I will test your patch ASAP

-- 
Maxime
