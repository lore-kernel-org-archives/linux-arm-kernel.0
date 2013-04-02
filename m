From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 2 Apr 2013 15:38:22 +0530
Subject: [PATCH] ARM: davinci: remove test for undefined Kconfig macro
In-Reply-To: <1364560405.1345.67.camel@x61.thuisdomein>
References: <1364557655.1345.58.camel@x61.thuisdomein>
 <1364560405.1345.67.camel@x61.thuisdomein>
Message-ID: <515AAE16.4080200@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/29/2013 6:03 PM, Paul Bolle wrote:
> [Dropped Kevin Hilman, because Kevin's address bounces.]

Use khilman at deeprootsystems.com as updated in MAINTAINERS.

> 
> On Fri, 2013-03-29 at 12:47 +0100, Paul Bolle wrote:
>> The DaVinci debugging macro contains a check for
>> CONFIG_DEBUG_DAVINCI_DA8XX_UART0. But there's corresponding Kconfig
> 
>                                   [...] there's no corresponding [...]
> 
>> symbol, so this test will always evaluate to false. That Kconfig symbol
>> is not needed because, as __arch_decomp_setup() shows, there are no
>> DaVinci DA8XX boards that use UART0 for debugging. We can remove two
>> lines of unneeded code.

Queuing this for v3.10 with updated commit text indicated above.

Thanks,
Sekhar
