From: stefan@datenfreihafen.org (Stefan Schmidt)
Date: Sun, 6 Feb 2011 13:21:50 +0100
Subject: [PATCH] Clean up set_pxa_fb_info
In-Reply-To: <20110206115254.GA13084@n2100.arm.linux.org.uk>
References: <20110206115254.GA13084@n2100.arm.linux.org.uk>
Message-ID: <20110206122150.GB7822@excalibur.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On Sun, 2011-02-06 at 11:52, Russell King - ARM Linux wrote:
> set_pxa_fb_info() has been a long-standing wart in the naming scheme
> of the pxa_set_xxx_info() functions.  This renames the function, and
> combines set_pxa_fb_parent() with set_pxa_fb_info().
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

For the EZX part:

>  arch/arm/mach-pxa/ezx.c                   |   12 ++++++------

Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>

regards
Stefan Schmidt
