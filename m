From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 26 Oct 2009 22:14:52 +0100
Subject: [PATCH 2.6.32] drivers/serial/atmel_serial.c: Fix BUILD_BUG_ON
	build
In-Reply-To: <1256569964-14416-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1256569964-14416-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <20091026211452.GB2561@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15:12 Mon 26 Oct     , Mark Brown wrote:
> Since 'BUILD_BUG_ON(): fix it and a couple of bogus uses of it'
> (commit 8c87df45) the BUILD_BUG_ON() for the ring buffer size has
> failed to build due to use of is_power_of_2(). Fix this in the
> same way as the SPARC vio.h was fixed in that commit by converting
> to MAYBE_BUILD_BUG_ON().
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
a similatr patch done by Haavard
atmel_serial-fix-bad-build_bug_on-usage.patch 
is already in the -mm

btw when it will be merged?

Best Regards,
J.
