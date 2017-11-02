From: broonie@kernel.org (Mark Brown)
Date: Thu, 2 Nov 2017 11:21:00 +0000
Subject: [PATCH] ASoC: stm32: sai: attempt to fix uninitialized variable
In-Reply-To: <20171102111620.3688534-1-arnd@arndb.de>
References: <20171102111620.3688534-1-arnd@arndb.de>
Message-ID: <20171102112100.whlosjahisgtboi7@sirena.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 02, 2017 at 12:15:48PM +0100, Arnd Bergmann wrote:
> After commit 61fb4ff70377 ("ASoC: stm32: sai: Move static
> settings to DAI init"), we get a valid warning about the
> use of an uninitialized variable:

A fix was already sent for this.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171102/bdb16709/attachment.sig>
