From: broonie@kernel.org (Mark Brown)
Date: Tue, 15 Dec 2015 18:27:10 +0000
Subject: [PATCH v6 5/8] spi: imx: allow only WML aligned transfers to use
 DMA
In-Reply-To: <1449557030-27525-6-git-send-email-anton.bondarenko.sama@gmail.com>
References: <1449557030-27525-1-git-send-email-anton.bondarenko.sama@gmail.com>
 <1449557030-27525-6-git-send-email-anton.bondarenko.sama@gmail.com>
Message-ID: <20151215182710.GD5727@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 08, 2015 at 07:43:47AM +0100, Anton Bondarenko wrote:

> Also removing change introduced in f6ee9b582d2db652497b73c1f117591dfb6d3a90
> since this change only fix usecases with transfer size from 33 to 128 bytes
> and doesn't fix 129 bytes and bigger.

This is a bug fix for stable but it's randomly in the middle of the
patch series so I can't apply it as such :(  Please send this as a bug
fix suitable for sending to Linus.

Please also include human readable descriptions of things like commits
and issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151215/5b8e4fa0/attachment.sig>
