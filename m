From: avictor.za@gmail.com (Andrew Victor)
Date: Wed, 23 Dec 2009 22:26:56 +0200
Subject: [PATCH] pcmcia/at91_cf: don't redefine SZ_2K
In-Reply-To: <20091222162827.GA20681@pengutronix.de>
References: <1261343434-3920-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20091222152827.GB17191@n2100.arm.linux.org.uk>
	<20091222162827.GA20681@pengutronix.de>
Message-ID: <cd73a99e0912231226r49dd53b8wfd7555b3db08a712@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,
>> Have you checked whether everything which uses at91_cf still builds after
>> this patch has been applied (eg, AVR32 stuff?)

> I wasn't aware that the driver is used on AVR32, too.

I don't think the AVR32 arch uses this driver.  So the patch should be
fine to apply.


Regards,
  Andrew Victor
