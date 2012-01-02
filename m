From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 02 Jan 2012 17:00:38 +0100
Subject: [PATCH] clocksource/ux500-prcmu: fix sched_clock breakage
In-Reply-To: <1325510583-4487-1-git-send-email-linus.walleij@stericsson.com>
References: <1325510583-4487-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <4F01D4A6.5010906@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/02/2012 02:23 PM, Linus Walleij wrote:
> commit 2f0778afac79bd8d226225556858a636931eeabc adding
> runtime-selectable sched_clock() forgot to patch this
> driver down in drivers/clocksource, this patch fixes
> the problem.
> 
> Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---

Compiled and booted the board successfully.

Tested-by: Daniel Lezcano <daniel.lezcano@linaro.org>

- -- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJPAdSmAAoJEAKBbMCpUGYAKAAIAMwJ3MKCS2mCM07mI27Cgchu
p0342JLh/xiCXeuCGYr8Z1WNGGRsj6GWcLPUs8Uhd8m75o6Hl8s2E+ZC3ki45Uum
C5uateI4MAh/gUi68aB8wdpzXQm+vr5SAy4pLaVmNUdS+X9XC8p23E3tmfoO9cWI
Ygk4g1Czzx7HQIANiHNeK0Da2juI6Hv7j5JJ2fm0kw25HEMvg0mQlKoF0U7CiYGe
KBjoUvR5RG+NcfNplGR+VYjv4xsmDfUo/7AjlPfwJ5n0RPVEJ9R5TAyOtBK/3RA7
6hUJ+KizevpWh8TxbS8Qz9jdkRXaji+5fy/L53+rxc8hKgfK1DNaMs2mt2eK6Qg=
=3GNF
-----END PGP SIGNATURE-----
