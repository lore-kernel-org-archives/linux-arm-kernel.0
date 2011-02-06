From: grinberg@compulab.co.il (Igor Grinberg)
Date: Sun, 06 Feb 2011 14:37:51 +0200
Subject: [PATCH] Clean up set_pxa_fb_info
In-Reply-To: <20110206115254.GA13084@n2100.arm.linux.org.uk>
References: <20110206115254.GA13084@n2100.arm.linux.org.uk>
Message-ID: <4D4E961F.9020709@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> set_pxa_fb_info() has been a long-standing wart in the naming scheme
> of the pxa_set_xxx_info() functions.  This renames the function, and
> combines set_pxa_fb_parent() with set_pxa_fb_info().
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Igor Grinberg <grinberg@compulab.co.il>

For:

>  arch/arm/mach-pxa/cm-x2xx.c               |    2 +-
>  arch/arm/mach-pxa/cm-x300.c               |    2 +-
>  arch/arm/mach-pxa/em-x270.c               |    2 +-
>


-- 
Regards,
Igor.
