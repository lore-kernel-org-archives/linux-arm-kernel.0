From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 24 Nov 2010 15:33:21 +0000 (UTC)
Subject: [PATCH] Acme Systems FOX Board G20 board files
References: <1287014786-25543-1-git-send-email-tanzilli@acmesystems.it>
Message-ID: <loom.20101124T163017-839@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One more thing, Sergio,

Sergio Tanzilli <tanzilli <at> acmesystems.it> writes:

> 
> ---
>  arch/arm/mach-at91/Kconfig        |    7 +
>  arch/arm/mach-at91/Makefile       |    2 +
>  arch/arm/mach-at91/board-foxg20.c |  279 +++++++++++++++++++++++++++++++++++++

[..]

> +MACHINE_START(FOXG20, "Acme Systems srl FOX Board G20")

It seems your machine is not registered with FOXG20 name in Russell's machine
registry: it is "ACMENETUSFOXG20".

So, tell me which name to use and should I modify your patch to cope with what
is already in mach-types...

Best regards,
-- 
Nicolas Ferre
