From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 1 Mar 2011 18:23:46 -0300
Subject: [PATCH 2/2] ARM: mx3/pcm043: fix build failure
In-Reply-To: <1299011459-18200-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20110301203018.GY22310@pengutronix.de>
	<1299011459-18200-2-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <AANLkTi=Yu0O4T92UAeCnDg8-vdJXEOMB80i5JE+x+=PT@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hallo Uwe,

2011/3/1 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Commit
>
> ? ? ? ?530aca5 (arm: mach-mx3: pcm043: add write-protect and card-detect for SD1)
>
> assigned a non-existing member .cd_gpio in a struct esdhc_platform_data.
> Though I expect this to change soon I remove it for now to unbreak the
> autobuilders.

Same error happens on mx25_3ds. Would you like me to send a patch for
fixing it for mx25_3ds too?

Regards,

Fabio Estevam
