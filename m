From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 30 Apr 2011 18:30:11 +0200
Subject: [PATCH 01/10] Add a common struct clk
In-Reply-To: <20110430090159.GA22821@n2100.arm.linux.org.uk>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-2-git-send-email-s.hauer@pengutronix.de>
	<BANLkTim5qh_G9t9ucFu8OUzYGceszth1wg@mail.gmail.com>
	<20110430090159.GA22821@n2100.arm.linux.org.uk>
Message-ID: <BANLkTiknEJQxZRZJDMXxQBeeUce5JLVXCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/30 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> we decided that the enable call shall be
> non-sleeping for everything. ?That's why we introduced the prepare
> call for the sleeping part of the problem.

Ah, that makes perfect sense. Let's go ahead with this.

Yours,
Linus Walleij
