From: avictor.za@gmail.com (Andrew Victor)
Date: Tue, 27 Oct 2009 22:13:34 +0200
Subject: [PATCH] at91: support for eco920
In-Reply-To: <20091023182023.GB3440@pengutronix.de>
References: <20091021084826.GA29667@n2100.arm.linux.org.uk>
	<1256115527-20635-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20091021151917.GE19714@game.jcrosoft.org>
	<20091023121152.GB1821@pengutronix.de>
	<20091023175629.GB29430@game.jcrosoft.org>
	<20091023182023.GB3440@pengutronix.de>
Message-ID: <cd73a99e0910271313k60fd7f47lbff0a3bb3596f04b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

> Hm, this is only slightly better:
>
> ? ? ? ?linux-2.6$ grep CONFIG_ARCH_AT91RM9200=y arch/arm/configs/* | wc -l
> ? ? ? ?12
>
> Andrew, thoughts? ?Are you interested at all in reducing the number of
> defconfigs for at91?

Not really.
A specific board usually has a specific set of peripherals, so
requires its own configuration file to enable those peripherals.
I'm not sure how useful a "generic" defconfig would be.....

[I see from the Makefile there are 13 AT91RM9200-based boards
currently supported in mainline, so there is already 1 which doesn't
have a defconfig]


Regards,
  Andrew Victor
