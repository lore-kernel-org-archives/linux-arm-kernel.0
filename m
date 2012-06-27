From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 27 Jun 2012 12:40:03 +0100
Subject: [RFC 0/3] Add cyclic DMA support to OMAP DMA engine driver
In-Reply-To: <20120625111847.GE19226@n2100.arm.linux.org.uk>
References: <20120622085911.GA19026@n2100.arm.linux.org.uk>
 <20120622123013.GA7586@sirena.org.uk>
 <20120622131750.GB19226@n2100.arm.linux.org.uk>
 <20120622161155.GM4037@opensource.wolfsonmicro.com>
 <20120625111847.GE19226@n2100.arm.linux.org.uk>
Message-ID: <20120627114003.GG308@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2012 at 12:18:47PM +0100, Russell King - ARM Linux wrote:

> It appears to be something to do with the jack detection that's going wrong.
> If I start the audio with the jack disconnected, I never get anything out
> of the board.  It requires the jack to be connected before the first use.
> The on-board speakers used to work without the jack plugged in at one time
> but they seem to be completely non-functional now.

> Confused.

Me too - there's nothing obvious in the code just from inspection that
would affect this.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120627/66482047/attachment.sig>
