From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Mar 2013 22:01:44 +0000
Subject: [GIT PULL] clocksource cleanup for 3.10
In-Reply-To: <513E38BD.4080407@gmail.com>
References: <513E38BD.4080407@gmail.com>
Message-ID: <201303152201.44785.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 11 March 2013, Rob Herring wrote:
> Please pull. This improves the clocksource init to avoid double matching
> to the DT device node. The clocksource init function changes are needed
> for any other clocksource conversions to CLKSRC_OF, so we need to make
> sure any other conversions use this branch (It happens to silently work
> without warnings, but there would be a mismatch in function ptrs). I'm
> including the twd_smp timer support for CLKSRC_OF here because of the
> dependency on this change.
> 

Pulled into next/cleanup branch, thanks!

	Arnd
