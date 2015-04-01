From: slash.tmp@free.fr (Mason)
Date: Wed, 01 Apr 2015 14:47:52 +0200
Subject: Reading twd_base at run-time
In-Reply-To: <551BE476.2060102@arm.com>
References: <55158261.9010108@free.fr> <551586E6.3020200@arm.com>
 <5515BEA5.6040307@free.fr> <20150327205301.GD4019@n2100.arm.linux.org.uk>
 <551BDF69.4020205@free.fr> <551BE476.2060102@arm.com>
Message-ID: <551BE8F8.60301@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/2015 14:28, Marc Zyngier wrote:

> It is worth mentioning that PERIPH_BASE is *not* an architected
> register, so an implementation is perfectly allowed not to implement it.
> Even on Cortex A9, a UP implementation will report PERIPH_BASE as zero.
> It is still likely to have a TWD though.

I understand now that the kernel cannot reliably discover PERIPH_BASE
at run-time; thus this piece of info must be communicated through DT.

> Indeed. And when probing is so unreliable, it is not worth using it.

Regards.
