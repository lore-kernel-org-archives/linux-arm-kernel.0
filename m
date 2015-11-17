From: broonie@kernel.org (Mark Brown)
Date: Tue, 17 Nov 2015 22:52:00 +0000
Subject: [PATCH 2/8] Documentation/spi/spidev_test.c: clean up input_tx
In-Reply-To: <5345436.HCqatbevmx@jclayton-pc>
References: <cover.1447773299.git.stillcompiling@gmail.com>
 <7f2139b27013d77993c6bc2b0a6c94fab01add98.1447773299.git.stillcompiling@gmail.com>
 <20151117174333.GY31303@sirena.org.uk>
 <5345436.HCqatbevmx@jclayton-pc>
Message-ID: <20151117225200.GG31303@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2015 at 11:21:12AM -0800, Joshua Clayton wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> It takes some clutter out of main() whose scope is limited to that little block of code, 
> and because in the next patch we add another (larger)function to the if/else block.

> I don't know if it is valid to say "look at the next commit" for justification, but
> That is the reason.

That's totally fine - just say that it's to support future changes in
this area.  It's good to split out mechanical changes like this from the
more complex changes, you just need to say why they're happening.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151117/0a2f7f03/attachment.sig>
