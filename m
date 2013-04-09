From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Apr 2013 22:21:10 +0200
Subject: [GIT PULL 02/10] 2nd irq-s3c24xx for v3.10
In-Reply-To: <201304092219.54078.arnd@arndb.de>
References: <516309D9.7000609@samsung.com> <201304092219.54078.arnd@arndb.de>
Message-ID: <201304092221.10650.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 April 2013, Arnd Bergmann wrote:
> On Monday 08 April 2013, Kukjin Kim wrote:
> > s3c24xx irq cleanup and move into drivers/irqchip
> 
> I had a little trouble applying this because of the interface change to
> CLOCKSOURCE_OF_DECLARE. This is the rather complex merge I did. Please
> check that it still works.

The reply should have been for patch 3/10. I've merged both into the
next/drivers branch.

	Arnd
