From: pebolle@tiscali.nl (Paul Bolle)
Date: Sun, 16 Feb 2014 20:12:45 +0100
Subject: [PATCH] arm: imx: remove MACH_MXLADS
In-Reply-To: <1392577615.265469392@f161.i.mail.ru>
References: <1392573811.28866.22.camel@x220>
 <1392574562.956803244@f244.i.mail.ru> <1392576223.28866.24.camel@x220>
 <1392577615.265469392@f161.i.mail.ru>
Message-ID: <1392577965.28866.37.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2014-02-16 at 23:06 +0400, Alexander Shiyan wrote:
> Kconfig selects MACH_MXLADS, this enables machine_arch_type
> from include/generated/mach-types.h which used for machine_is_xx() macro,
> so if multiple boards is defined in the kernel, this cause to incorrect matching.

But, as I stated in the commit explanation, there are no users of
machine_is_mxlads().

> Russel, Arnd, fixme.

What does that mean?


Paul Bolle
