From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 10 Dec 2009 17:50:07 +0000
Subject: [PATCH] ARM: Convert BUG() to use unreachable()
In-Reply-To: <1260266138-17684-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1260266138-17684-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20091210175007.GC13210@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 08, 2009 at 10:55:38AM +0100, Uwe Kleine-K?nig wrote:
> Use the new unreachable() macro instead of for(;;);

Have you investigated what effect this has on generated code?
