From: broonie@kernel.org (Mark Brown)
Date: Thu, 26 Mar 2015 08:38:55 -0700
Subject: [RFC 4/6] spi: atmel: use atmel_io.h to provide on-chip IO
In-Reply-To: <1427370354-21247-5-git-send-email-ben.dooks@codethink.co.uk>
References: <1427370354-21247-1-git-send-email-ben.dooks@codethink.co.uk>
 <1427370354-21247-5-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20150326153855.GP3572@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 26, 2015 at 11:45:52AM +0000, Ben Dooks wrote:
> Use <linux/atmel_io.h> to provide IO accessors which work on both
> AVR32 and ARM for on-chip peripherals.

To repeat the feedback on your previous big endian fix: I've not been
CCed on the cover letter or any of the other patches so can someone tell
me if there are any dependencies or anything?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150326/fd3c92b5/attachment-0001.sig>
