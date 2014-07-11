From: broonie@kernel.org (Mark Brown)
Date: Fri, 11 Jul 2014 13:39:49 +0100
Subject: [PATCH] spi: efm32: correct namespacing of location property
In-Reply-To: <1405066677-12858-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <CAOesGMjgX5PWBSD2YP7mTGMWafxBjeMDmzZoPCXb27YPUHEcyw@mail.gmail.com>
 <1405066677-12858-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20140711123949.GM30458@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 11, 2014 at 10:17:57AM +0200, Uwe Kleine-K?nig wrote:
> Olof Johansson pointed out that usually the company name is picked as
> namespace prefix to specific properties. So expect "energymicro,location"
> but fall back to the previously introduced name "efm32,location".

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140711/a622b1d9/attachment-0001.sig>
