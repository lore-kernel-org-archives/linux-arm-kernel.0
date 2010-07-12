From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 12 Jul 2010 16:35:49 +0800
Subject: [RFC PATCH 1/2] allow each machine to specify it's own IRQ
	handlers at run-time
In-Reply-To: <20100712081245.GC22138@n2100.arm.linux.org.uk>
References: <AANLkTin9OHUGtKSg7554ucVhufQ3PiKXALmD0Lh7A-yt@mail.gmail.com>
	<20100712081106.GB1532@pengutronix.de>
	<20100712081245.GC22138@n2100.arm.linux.org.uk>
Message-ID: <AANLkTilFXqyacUU4vO-_iDleJzs60w9pPsrMJiTrHixz@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/7/12 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Mon, Jul 12, 2010 at 10:11:06AM +0200, Uwe Kleine-K?nig wrote:
>> I didn't thought it would be that easy. ?Nice.
>> Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>
> It isn't - if you enable this, your platform will break because
> there's no implementations of it. ?That makes this patch rather
> hard to ack on its own.
>

The idea is for platforms supporting its own IRQ handler to have an
implementation before it's selected in Kconfig, if that makes sense
for this to be standalone?
