From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 4 Apr 2011 14:21:10 -0300
Subject: [PATCH v2] ARM: mx5/mx53_smd: Add esdhc support
In-Reply-To: <20110404160012.GE13963@pengutronix.de>
References: <1301920375-31761-1-git-send-email-fabio.estevam@freescale.com>
	<20110404160012.GE13963@pengutronix.de>
Message-ID: <BANLkTikc8=iwPk0vtUHMqYn5Hg2Xg=3u2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

2011/4/4 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> On Mon, Apr 04, 2011 at 09:32:55AM -0300, Fabio Estevam wrote:
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>> ---
>> Changes since v1:
>> - Do not use CD and WP detecion via GPIO as it is not working for MX53 yet.
>>
>> ?arch/arm/mach-mx5/board-mx53_smd.c | ? 28 ++++++++++++++++++++++++++++
> You need to let MACH_MX53_SMD select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX.

Correct. I have already sent v3 that addresses this point.

Regards,

Fabio Estevam
