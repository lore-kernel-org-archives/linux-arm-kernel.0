From: nsz@port70.net (Szabolcs Nagy)
Date: Mon, 17 Nov 2014 15:11:23 +0100
Subject: ARM atomics overhaul for musl
In-Reply-To: <20141117135412.GC29595@e104818-lin.cambridge.arm.com>
References: <20141116055656.GA13940@brightrain.aerifal.cx>
 <20141116163355.GK4042@n2100.arm.linux.org.uk>
 <20141116165017.GT22465@brightrain.aerifal.cx>
 <20141116171055.GM4042@n2100.arm.linux.org.uk>
 <20141117135412.GC29595@e104818-lin.cambridge.arm.com>
Message-ID: <20141117141123.GG10829@port70.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Catalin Marinas <catalin.marinas@arm.com> [2014-11-17 13:54:13 +0000]:
> ARM11MPCore). ARM is trying to move away from architecture version
> numbers, which are rather useful for marketing, to proper feature
> detection based on CPUID. Whether there is an ARMv9 or not, it's
> irrelevant to what Linux should do (i.e. use CPUID rather than guess
> features based on architecture version numbers).
> 

how to use cpuid from userspace?

should linux export those bits into hwcap?

(i assume all relevant info will be available in /proc/cpuinfo but
that does not work for libc)
