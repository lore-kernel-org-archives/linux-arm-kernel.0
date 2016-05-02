From: broonie@kernel.org (Mark Brown)
Date: Mon, 2 May 2016 16:40:23 +0100
Subject: [PATCH v6] spi: orion.c: Add direct access mode
In-Reply-To: <8919835.yGyvx4h0Tr@wuerfel>
References: <1461147068-4829-1-git-send-email-sr@denx.de>
 <5726F7F3.9070700@denx.de> <8919835.yGyvx4h0Tr@wuerfel>
Message-ID: <20160502154023.GI6292@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 02, 2016 at 09:28:34AM +0200, Arnd Bergmann wrote:
> On Monday 02 May 2016 08:47:15 Stefan Roese wrote:

> > Its been a while since v6 of this direct write access mode has been
> > posted. This is a gentle ping on its status.

> > Arnd / Mark, do you have any additional change requests or are you okay
> > with the current version?

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so 
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.
Sending content free pings just adds to the mail volume (if they are
seen at all) and if something has gone wrong you'll have to resend the
patches anyway.

> - you now always send a multiple of four byte in each transfer, are
>   there any downsides in doing this, e.g. some SPI devices that might
>   get confused by receiving additional uninitialized data?

Yes, this will break a large proportion of devices.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160502/b84af846/attachment.sig>
