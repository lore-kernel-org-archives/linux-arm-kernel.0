From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 11 Apr 2011 15:43:20 +0200
Subject: [RFC PATCH 0/5] Convert some ARM platforms to basic-mmio-gpio
In-Reply-To: <1302522502-24381-1-git-send-email-jamie@jamieiles.com>
References: <1302522502-24381-1-git-send-email-jamie@jamieiles.com>
Message-ID: <20110411134320.GJ18601@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 11, 2011 at 12:48:17PM +0100, Jamie Iles wrote:
> The basic-mmio-gpio driver has been extended in
> <http://marc.info/?l=linux-kernel&m=130252092900804&w=2> to support a
> larger wider of controllers and this series converts the ARM platforms
> that do not implement I/O muxing in the GPIO driver or use the .to_irq
> method of gpio_chip to use the driver.
As these patches are necessary to test at least the mxc patch but they
are not present in todays next and I don't want to spend the time to
find the patches on marc.info (the "next in thread" link is greyed out)
and it's non-trivial to get patches from marc into git (
wget -O - 'http://marc.info/?l=linux-kernel&m=130252092900807&q=raw' | git am
fails with "Patch does not have a valid e-mail address." because the raw
view doesn't provide the From: header (Subject: is missing, too)) can
you please point out a repository that has all 12 patches?

Did you (or someone else) measure the performance difference these
patches introduce?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
