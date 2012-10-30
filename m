From: tony@atomide.com (Tony Lindgren)
Date: Tue, 30 Oct 2012 12:36:34 -0700
Subject: [RFC 2/7] capebus: Add beaglebone board support
In-Reply-To: <1351702333-8456-3-git-send-email-panto@antoniou-consulting.com>
References: <1351702333-8456-1-git-send-email-panto@antoniou-consulting.com>
 <1351702333-8456-3-git-send-email-panto@antoniou-consulting.com>
Message-ID: <20121030193633.GQ11908@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pantelis Antoniou <panto@antoniou-consulting.com> [121030 12:00]:
> +#include <plat/clock.h>
> +#include <plat/omap_device.h>

We already have queued patches to make omap_device.h
private to arch/arm/mach-omap2. Then plat/clock.h will
be gone with the common clock framework patches.

Regards,

Tony
