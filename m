From: broonie@kernel.org (Mark Brown)
Date: Wed, 1 Jan 2014 13:24:43 +0000
Subject: [PATCH 0/2] spi: clps711x: SPI driver refactor
In-Reply-To: <1388556488-10887-1-git-send-email-shc_work@mail.ru>
References: <1388556488-10887-1-git-send-email-shc_work@mail.ru>
Message-ID: <20140101132443.GQ31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 01, 2014 at 10:08:08AM +0400, Alexander Shiyan wrote:

> Since we do not have any platform users of this driver,
> non-DT support is removed. DT users will be introduced later
> once DT support for this platform will be completed.
> "ACK" from arm-soc maintainers will be useful here.

That's not likely to happen given that you didn't CC them, though it
shouldn't be need anyway - there's no reason for the arm-soc guys to
have to review driver changes.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140101/2ba37789/attachment.sig>
