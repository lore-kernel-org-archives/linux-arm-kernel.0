From: pavel@denx.de (Pavel Machek)
Date: Thu, 30 May 2013 12:37:00 +0200
Subject: [PATCH v8] reset: Add driver for gpio-controlled reset pins
In-Reply-To: <1369904940-716-1-git-send-email-p.zabel@pengutronix.de>
References: <1369904940-716-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20130530103659.GA24712@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> This driver implements a reset controller device that toggle a gpio
> connected to a reset pin of a peripheral IC. The delay between assertion
> and de-assertion of the reset signal can be configured via device tree.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Reviewed-by: Stephen Warren <swarren@nvidia.com>

Reviewed-by: Pavel Machek <pavel@ucw.cz>

Seems ok to me. Having value = asserted is interesting, but you are
basically using it as a documentation, so it looks ok.

Thanks,

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
