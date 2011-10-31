From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 31 Oct 2011 14:16:11 +0100
Subject: config ARCH_AT91SAM9X5
In-Reply-To: <1320062362.14409.58.camel@x61.thuisdomein>
References: <1320062362.14409.58.camel@x61.thuisdomein>
Message-ID: <4EAE9F9B.4040201@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/31/2011 12:59 PM, Paul Bolle wrote:
> 0) Since the commits
>     9baeb7e4 ("at91: Add ARCH_ID and basic cpu macros [...]"),
>     b9e379bc ("net/can: allow CAN_AT91 on AT91SAM9X5"), and
>     8c3583b6 ("at91: use structure to store the current soc")
> 
> the mainline kernel tree uses the Kconfig symbol ARCH_AT91SAM9X5 and the
> preprocessor macro CONFIG_ARCH_AT91SAM9X5.
> 
> 1) But there's currently no Kconfig entry ARCH_AT91SAM9X5. (Neither is
> there a direct definition of the macro CONFIG_ARCH_AT91SAM9X5.)
> Shouldn't a Kconfig entry for ARCH_AT91SAM9X5 be added (to
> arch/arm/mach-at91/Kconfig)?

Talking for the at91_can driver (which has been done by me):
The driver and Kconfig have been prepared for the upcoming 5series AT91
SOCs.

Basically the same applies to the commit 9baeb7e4 ("at91: Add ARCH_ID
and basic cpu macros [...]").

But the 5series hasn't bee merged yet. Nicolas and Jean-Christophe can
probably tell you more.

regards, Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 262 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111031/7e70a2cc/attachment.sig>
