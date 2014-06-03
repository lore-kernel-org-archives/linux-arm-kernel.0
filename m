From: broonie@kernel.org (Mark Brown)
Date: Tue, 3 Jun 2014 23:00:50 +0100
Subject: [PATCH] ASoC: pxa: add I2C dependencies as needed
In-Reply-To: <46560700.2S4p0nUZl8@wuerfel>
References: <46560700.2S4p0nUZl8@wuerfel>
Message-ID: <20140603220050.GC2520@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 03, 2014 at 08:38:27PM +0200, Arnd Bergmann wrote:
> We have in the past added 'depends on I2C' for some of the PXA boards
> after hitting randconfig build bugs. I have seens a couple of new
> bugs in this area during the linux-next cycle for 3.16, after it
> became possible to build some more PXA machines with I2C disabled.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140603/e9bc11a7/attachment.sig>
