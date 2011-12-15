From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 15 Dec 2011 14:47:57 +0000
Subject: [PATCH] ARM: add device tree blobs to .gitignore
In-Reply-To: <1323808612-14976-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1323808612-14976-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20111215144757.GA2081@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2011 at 09:36:52PM +0100, Uwe Kleine-K??nig wrote:
> *.dtb files are a build result and so should be ignored.
> 
> Signed-off-by: Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>

Should this actually be global?

It looks like at least powerpc, microblaze and openrisc may generate
.dtbs and I don't see any local .gitignore entries for those.

Since the dtc tool itself is global (i.e., in an arch-independent
scripts dir instead of somewhere arch-specific), it could be argued that
other related stuff should be global too.

Cheers
---Dave
