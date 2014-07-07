From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Jul 2014 11:49:44 +0100
Subject: [PATCH] ARM: OMAP2+: l2c: squelch warning dump on power
 control setting
In-Reply-To: <20140707104727.GM28884@atomide.com>
References: <3c3a7a4861df01d0163787a9c18f7b7ac821c5b9.1403000372.git.nsekhar@ti.com>
 <20140617131935.GB9070@saruman.home> <20140701194704.GG13396@saruman.home>
 <20140702081142.GU28884@atomide.com> <20140707104727.GM28884@atomide.com>
Message-ID: <20140707104944.GS3705@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 07, 2014 at 03:47:27AM -0700, Tony Lindgren wrote:
> That's now merged into v3.16-rc4, so applying this into
> omap-for-v3.16/fixes.

I intentionally left the warning in the hope that someone would update
it to write to the register.

>From the comments in the patch, it seems that firmware doesn't provide
a method to do that, which is a tad annoying.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
