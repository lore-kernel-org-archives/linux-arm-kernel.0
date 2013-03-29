From: pebolle@tiscali.nl (Paul Bolle)
Date: Fri, 29 Mar 2013 13:33:25 +0100
Subject: [PATCH] ARM: davinci: remove test for undefined Kconfig macro
In-Reply-To: <1364557655.1345.58.camel@x61.thuisdomein>
References: <1364557655.1345.58.camel@x61.thuisdomein>
Message-ID: <1364560405.1345.67.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Dropped Kevin Hilman, because Kevin's address bounces.]

On Fri, 2013-03-29 at 12:47 +0100, Paul Bolle wrote:
> The DaVinci debugging macro contains a check for
> CONFIG_DEBUG_DAVINCI_DA8XX_UART0. But there's corresponding Kconfig

                                  [...] there's no corresponding [...]

> symbol, so this test will always evaluate to false. That Kconfig symbol
> is not needed because, as __arch_decomp_setup() shows, there are no
> DaVinci DA8XX boards that use UART0 for debugging. We can remove two
> lines of unneeded code.


Paul Bolle
