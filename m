From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Dec 2010 23:06:07 +0000
Subject: [PATCH 33/40] ARM: tegra: convert sched_clock() to use new
	infrastructure
In-Reply-To: <AANLkTimMrHtEGYX=7AHQUNCdxU8xNEbfFP5he5kth8F_@mail.gmail.com>
References: <20101217113223.GC9937@n2100.arm.linux.org.uk>
	<E1PTYoY-0006jm-UT@rmk-PC.arm.linux.org.uk>
	<AANLkTimMrHtEGYX=7AHQUNCdxU8xNEbfFP5he5kth8F_@mail.gmail.com>
Message-ID: <20101222230607.GI14693@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 21, 2010 at 11:23:58PM -0800, Olof Johansson wrote:
> This needs:
> 
> #include <asm/sched_clock.h>
> 
> (for DEFINE_CLOCK_DATA and other declarations)

Fixed, thanks for testing.
