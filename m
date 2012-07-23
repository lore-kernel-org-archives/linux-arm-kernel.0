From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 23 Jul 2012 11:23:36 +0100
Subject: [PATCH 2/16] SPI: Refactor spi-orion to use SPI framework queue.
In-Reply-To: <20120723101641.GD18778@lunn.ch>
References: <1342805751-18048-1-git-send-email-andrew@lunn.ch>
 <1342805751-18048-3-git-send-email-andrew@lunn.ch>
 <CACRpkdYBJmh3+EVrPGb8L2TTWkJkeejfDZX1G0T1KoYY-YuBLg@mail.gmail.com>
 <20120722095328.GB5423@lunn.ch>
 <20120722190700.GD4557@opensource.wolfsonmicro.com>
 <20120722193243.GF5423@lunn.ch>
 <20120722224241.GH4557@opensource.wolfsonmicro.com>
 <20120723072749.GA18778@lunn.ch>
 <20120723093747.GD4435@opensource.wolfsonmicro.com>
 <20120723101641.GD18778@lunn.ch>
Message-ID: <20120723102336.GH4435@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2012 at 12:16:41PM +0200, Andrew Lunn wrote:
> On Mon, Jul 23, 2012 at 10:37:47AM +0100, Mark Brown wrote:

> > The bit I was saying was most low risk was the actual DT changes, as
> > opposed to the bits that parse and use the DT.

> Ah, O.K. I understood you wrongly. I actually think they are the most
> dangerous part. A board booting with these DT changes, and without the
> driver enablement for DT is likely to fail to find its root
> filesystem.

Why would that be?  If there's no DT support for the driver it'll just
ignore the DT.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120723/ef1f9e24/attachment-0001.sig>
