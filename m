From: broonie@kernel.org (Mark Brown)
Date: Thu, 12 Oct 2017 16:51:31 +0100
Subject: regression introduced by commit 70d435ba1cd6 ("ASoC:
 imx-pcm-dma: simplify pcm_config")
In-Reply-To: <20171010171846.509f399e@karo-electronics.de>
References: <20171004103657.1c6a433d@karo-electronics.de>
 <1507646944.2398.1.camel@pengutronix.de>
 <20171010171846.509f399e@karo-electronics.de>
Message-ID: <20171012155131.zn6r47eaombcqdlk@sirena.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 10, 2017 at 05:18:46PM +0200, Lothar Wa?mann wrote:

> I circumvented the problem by changing my /etc/asound.conf to use the
> only supported sample format. So, if nobody else has a problem, there
> is no need to revert the patch or apply additional modifications to the
> driver.

I've not seen any other reports.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171012/5441e7eb/attachment.sig>
