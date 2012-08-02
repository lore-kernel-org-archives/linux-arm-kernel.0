From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 2 Aug 2012 12:52:27 -0300
Subject: [PATCH 0/7] Add support for Freescale's mc34708 to mc13xxx driver
In-Reply-To: <1342087073-3892-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1342087073-3892-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <CAOMZO5C0=eXYU8Vgnn0xGviXfLEjGgA0yn120NKpwL55m5rgbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Thu, Jul 12, 2012 at 6:57 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> Hello,
>
> This series was tested on a Phytec pcm038 (mc13783 on spi) using
> traditional boot (i.e. not dt) and on a i.MX53 based machine (mc34708 on
> i2c) using dt boot.
>
> Philippe's patches are already in next, they are just included here for
> those who want to test the patches. The 'mfd/mc13xxx: drop modifying
> driver's id_table in probe' was already sent out yesterday and is
> included here because the last patch depends on it.

Would you have a git tree with all these patches applied so that I can
easily test it on a mx53loco board?

Thanks,

Fabio Estevam
