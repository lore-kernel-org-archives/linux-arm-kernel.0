From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Thu, 23 Sep 2010 08:07:34 -0700 (PDT)
Subject: [PATCH] Fixing ethernet driver compilation error for i.MX32 ADS
	board
In-Reply-To: <1285252695.1864.10.camel@Tapajos>
Message-ID: <260783.23687.qm@web51006.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ian,

--- On Thu, 9/23/10, Ian Lartey <ian@opensource.wolfsonmicro.com> wrote:

> From: Ian Lartey <ian@opensource.wolfsonmicro.com>
> Subject: [PATCH] Fixing ethernet driver compilation error for i.MX32 ADS board
> To: "Sascha Hauer" <kernel@pengutronix.de>, "Uwe Kleine-K?nig" <u.kleine-koenig@pengutronix.de>, "linux-arm-kernel" <linux-arm-kernel@lists.infradead.org>
> Cc: "Wolfson Patches" <patches@opensource.wolfsonmicro.com>
> Date: Thursday, September 23, 2010, 11:38 AM
> Revert "ARM: mx3/mx31ads: fold board
> header in its only user"
> 
> This reverts commit
> ccfa7c269843001077df02d98918c6c9bde91395.
> As the board header is also used cs89x0 ethernet driver by
> the i.MX32 ADS.

Please change i.MX32 to i.MX31 in both the subject and commit message.

Regards,

Fabio Estevam


      
