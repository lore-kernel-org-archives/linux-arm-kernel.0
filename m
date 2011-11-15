From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 15 Nov 2011 11:16:04 +0000
Subject: [PATCH 2/2] MAINTAINERS: Extend Samsung patterns to cover SPI
 and ASoC drivers
In-Reply-To: <005701cca376$f6abbba0$e40332e0$%kim@samsung.com>
References: <1320923776-26626-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1320923776-26626-2-git-send-email-broonie@opensource.wolfsonmicro.com>
 <005701cca376$f6abbba0$e40332e0$%kim@samsung.com>
Message-ID: <20111115111603.GC3077@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 15, 2011 at 06:14:22PM +0900, Kukjin Kim wrote:
> Mark Brown wrote:

> > +F:	drivers/spi/spi-s3c*
> > +F:	sound/soc/samsung/*

> Hmm, I'm ok on this but needs Grant's opinion :)

> (Cc'ed Grant Likely)

Note that you can have multiple entries for a single file, people are
supposed to use a bit of thought when working out who to mail - if you
use something like get_maintainers it'll return all matching entries.
