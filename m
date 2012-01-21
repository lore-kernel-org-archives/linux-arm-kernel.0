From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 21 Jan 2012 18:47:42 -0200
Subject: [PATCH 1/3] ARM: mx3: Remove unneeded ifdef's from mm-imx3.c
In-Reply-To: <20120121204314.GA14835@pengutronix.de>
References: <1327084990-25402-1-git-send-email-fabio.estevam@freescale.com>
 <20120120232912.GP4066@pengutronix.de>
 <CAOMZO5CaqMm4eNMCWP9Dyb1kC84qx+zg00FyJMw0gs93Qv94Gg@mail.gmail.com>
 <20120121204314.GA14835@pengutronix.de>
Message-ID: <CAOMZO5DgXZmmQ_3AVRjs6CftbrULPSTj-PcNvzEx-KvuisjxYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/1/21 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:

> ... or by keeping the #ifdefs :-)

Yes, let's keep the #ifdefs

>> Would you like me to do this?
> I don't care much and pass the question to Sascha.

Ok, let's drop 1/3 for now.

My main goal in this patch series is patch 3/3 that fixes LPM setting on mx35.

Regards,

Fabio Estevam
