From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 04 Nov 2011 11:27:35 +0100
Subject: config ARCH_AT91SAM9X5
In-Reply-To: <4EAE9F9B.4040201@pengutronix.de>
References: <1320062362.14409.58.camel@x61.thuisdomein>
	<4EAE9F9B.4040201@pengutronix.de>
Message-ID: <4EB3BE17.2050001@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/31/2011 02:16 PM, Marc Kleine-Budde :
> On 10/31/2011 12:59 PM, Paul Bolle wrote:
>> 0) Since the commits 9baeb7e4 ("at91: Add ARCH_ID and basic cpu 
>> macros [...]"), b9e379bc ("net/can: allow CAN_AT91 on 
>> AT91SAM9X5"), and 8c3583b6 ("at91: use structure to store the 
>> current soc")
>> 
>> the mainline kernel tree uses the Kconfig symbol ARCH_AT91SAM9X5 
>> and the preprocessor macro CONFIG_ARCH_AT91SAM9X5.
>> 
>> 1) But there's currently no Kconfig entry ARCH_AT91SAM9X5. 
>> (Neither is there a direct definition of the macro 
>> CONFIG_ARCH_AT91SAM9X5.) Shouldn't a Kconfig entry for 
>> ARCH_AT91SAM9X5 be added (to arch/arm/mach-at91/Kconfig)?
> 
> Talking for the at91_can driver (which has been done by me): The 
> driver and Kconfig have been prepared for the upcoming 5series AT91
> SOCs.
> 
> Basically the same applies to the commit 9baeb7e4 ("at91: Add 
> ARCH_ID and basic cpu macros [...]").
> 
> But the 5series hasn't bee merged yet. Nicolas and Jean-Christophe 
> can probably tell you more.

Yes, AT91SAM9X5 support is underway to mainline kernel.
It was posted to the mailing-list a while ago but did not reached
acceptance due to the move to device tree on ARM platforms.
We have made progress on this side recently and will add this SoC
during this effort.

So, please keep this symbol for the moment as we may need it during
our submitting of 9x5 work.

Best regards,
- -- 
Nicolas Ferre
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJOs74LAAoJEAf03oE53VmQ+rIIAM8+rPAB3spWpzueeAcvtS+s
Hmaf5GqCblBpi4Kl9Q0ej6S8pLNWZJT8+DSAiUFE+a7IMsGULccg11BdgYX2sYMM
A5zo/50FrbWhWKl78Jmh42cdFqtDv2mSZLsgzNwrjMiNjt6V3V2eQha/xiL/gBsc
/pQgH1Q+gmvMUWz6WMSY1/4KzBPKzy18YVoxLK0uOot7sNlZIRKxjrxwUO6IXH8+
rrdNHx87ymbzz5RjUNZM3M3U+SkjU4DXmJBgkYyizh8/fdl5SYsgA+yNjES4B+88
Y+x+43Q8fvT1GSwTSCILNqRYOWNm8sQnC364nCPR10CBAd47mjsuF8IrbyBFkbM=
=Uzdk
-----END PGP SIGNATURE-----
