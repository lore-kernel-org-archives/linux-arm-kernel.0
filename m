From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 2 Aug 2013 10:03:47 +0100
Subject: [PATCH] ARM: allow DEBUG_UNCOMPRESS for omap2plus
In-Reply-To: <20130802072925.GX7656@atomide.com>
References: <1375224558-8170-1-git-send-email-swarren@wwwdotorg.org>
 <20130730225233.GF21614@n2100.arm.linux.org.uk>
 <51F845C7.8020106@wwwdotorg.org> <20130731064634.GR7656@atomide.com>
 <51F94200.2060202@wwwdotorg.org> <20130802072925.GX7656@atomide.com>
Message-ID: <20130802090347.GD23053@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 02, 2013 at 12:29:25AM -0700, Tony Lindgren wrote:
> It seems the best strategy seems to be to just init things later on
> so DEBUG_LL is only needed when booting breaks really early on
> during the boot process.

... which is exactly the whole point and use case of DEBUG_LL. :)
