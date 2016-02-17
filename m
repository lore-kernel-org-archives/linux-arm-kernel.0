From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 17 Feb 2016 13:40:42 -0200
Subject: [PATCH] i.MX SPI DMA cleanup
In-Reply-To: <56C492DB.6000405@de.bosch.com>
References: <1455715739-25161-1-git-send-email-s.hauer@pengutronix.de>
 <56C478C9.6050706@de.bosch.com>
 <20160217135441.GA3939@pengutronix.de>
 <56C47F64.1080706@de.bosch.com>
 <20160217145944.GB3939@pengutronix.de>
 <56C492DB.6000405@de.bosch.com>
Message-ID: <CAOMZO5Bcwf335VY2809YU2b_-+jntJ_pjNQw_E+jdvEYV==NrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2016 at 1:33 PM, Dirk Behme <dirk.behme@de.bosch.com> wrote:

> To my understanding, the TKT238285 hardware issue exists on both i.MX6Q and
> i.MX6DL. Even though the commit message in
>
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/spi/spi-imx.c?id=a02bb401f8ae264be782ee57d98bdd99f14c802
>
> states it differently. Maybe due to timing issues it happens less often on
> i.MX6Q and therefore wasn't in the focus there, yet.

Yes, this is my understanding as well.
