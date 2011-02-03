From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 3 Feb 2011 08:54:05 -0800
Subject: [PATCH v3 2/2] Input: ads7846: use gpio_request_one to configure
	pendown_gpio
In-Reply-To: <1296746506-12221-1-git-send-email-sourav.poddar@ti.com>
References: <1296746506-12221-1-git-send-email-sourav.poddar@ti.com>
Message-ID: <20110203165405.GB12802@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 03, 2011 at 08:51:46PM +0530, Sourav Poddar wrote:
> The ads7846 driver requests a gpio but does not currently
> configure it explicitly as an input. Use gpio_request_one
> to request and configure it at one shot.
> 
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> Cc: Dmitry Torokhov <dtor@mail.ru>

Will apply this one, the other one is a bit messy IMO, will have to
think about it.

Thanks.

-- 
Dmitry
