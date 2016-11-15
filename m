From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Nov 2016 15:50:45 +0000
Subject: [PATCH] ARM: cache-uniphier: include <linux/errno.h> instead of
 <linux/types.h>
In-Reply-To: <20161107161448.GJ1041@n2100.armlinux.org.uk>
References: <1478534334-15562-1-git-send-email-yamada.masahiro@socionext.com>
 <20161107161448.GJ1041@n2100.armlinux.org.uk>
Message-ID: <20161115155045.GX1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 07, 2016 at 04:14:48PM +0000, Russell King - ARM Linux wrote:
> On Tue, Nov 08, 2016 at 12:58:54AM +0900, Masahiro Yamada wrote:
> > Nothing in this header file depends on <linux/types.h>.
> > Rather, <linux/errno.h> should be included for -ENODEV.
> 
> So how do we end up with a definition for u32?
> 
> I think you need both these include files.

I've noticed you haven't responded to the above.

I've discarded the patch you've placed in the patch system in the hope
of a replacement with this comment addressed.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
