From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Sun, 27 Sep 2009 14:20:17 +0400
Subject: [PATCH] ARM: Remove unused CONFIG SA1100_H3XXX
In-Reply-To: <1253976606.4568.42.camel@ht.satnam>
References: <1253976606.4568.42.camel@ht.satnam>
Message-ID: <20090927102015.GA6703@rainbow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20:20 Sat 26 Sep     , Jaswinder Singh Rajput wrote:
> 
> Removed unused CONFIG SA1100_H3XXX from Kconfig and defconfig
> 
> Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
> Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
> Cc: Dmitry Artamonow <mad_soft@inbox.ru>
> Cc: Philipp Zabel <philipp.zabel@gmail.com>
> Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com>
> Cc: Russell King <rmk+lkml@arm.linux.org.uk>
> ---
>  arch/arm/configs/h3600_defconfig |    1 -
>  arch/arm/mach-sa1100/Kconfig     |    5 -----
>  2 files changed, 0 insertions(+), 6 deletions(-)

Yes, SA1100_H3XXX isn't used anywhere and can be removed safely.

Here's my
Acked-by: Dmitry Artamonow <mad_soft@inbox.ru>

-- 
Best regards,
Dmitry "MAD" Artamonow
