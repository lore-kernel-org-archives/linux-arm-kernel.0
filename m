From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Nov 2012 09:17:11 +0100
Subject: [PATCH V2 2/2] ARM: tegra: move timer.c to drivers/clocksource/
In-Reply-To: <20121120005036.GA6280@kryptos>
References: <1353371237-2482-1-git-send-email-swarren@wwwdotorg.org>
 <1353371237-2482-2-git-send-email-swarren@wwwdotorg.org>
 <20121120005036.GA6280@kryptos>
Message-ID: <20121120091711.2609af06@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Josh,

On Mon, 19 Nov 2012 18:50:36 -0600, Josh Cartwright wrote:

> I had suggested this with Thomas Petazzoni's consolidated irq_chip patch
> as well:
> 
> It seems like it would be a bit cleaner/easier to maintain if we relied
> on the linker to stitch together a clksrc_of_match table, based on what
> clocksources are being built into the image.  With that approach, at
> least, a public initialization header wouldn't have to be exposed, and
> this central table wouldn't have to be maintained (as more clocksrcs are
> added, I forsee [admittedly trivial] merge conflicts).

... and I indeed have a new version of my irqchip patches that indeed
use the linker to merge together the of_device_id entries!

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
