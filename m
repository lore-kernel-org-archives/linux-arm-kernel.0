From: broonie@kernel.org (Mark Brown)
Date: Tue, 10 Dec 2013 11:13:09 +0000
Subject: [PATCH 1/3] ARM: dts: Leave Exynos5250 SPI controller disabled
 by default
In-Reply-To: <CAD=FV=XEKUFWEM-30Bx0pVBOT8X0zXsdHyzq=pDY8TOcdGHgRg@mail.gmail.com>
References: <1385381710-5212-1-git-send-email-broonie@kernel.org>
 <CAD=FV=XEKUFWEM-30Bx0pVBOT8X0zXsdHyzq=pDY8TOcdGHgRg@mail.gmail.com>
Message-ID: <20131210111309.GD29268@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 09, 2013 at 04:57:01PM -0800, Doug Anderson wrote:

> I'm a little surprised that I don't see removal of spi_0 on SMDK5250.
> When I apply your patch to ToT Linux I still see this in
> "exynos5250-smdk5250.dts":

>         spi_0: spi at 12d20000 {
>                 status = "disabled";
>         };

I suspect that one went AWOL during rebasing - these have been kicking
around since September.  Resent with that added.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131210/88bbd7a4/attachment.sig>
