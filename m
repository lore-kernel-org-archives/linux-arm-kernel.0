From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 22 May 2017 12:28:12 +0200
Subject: [PATCH 3/3] mfd: twl: move header file out of I2C realm
In-Reply-To: <20170522095243.ff5uygzzrvo57jkd@sirena.org.uk>
References: <20170521220212.1404-1-wsa@the-dreams.de>
 <20170521220212.1404-4-wsa@the-dreams.de>
 <20170522095243.ff5uygzzrvo57jkd@sirena.org.uk>
Message-ID: <20170522102812.GA1459@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 22, 2017 at 10:52:43AM +0100, Mark Brown wrote:
> On Mon, May 22, 2017 at 12:02:10AM +0200, Wolfram Sang wrote:
> > include/linux/i2c is not for client devices. Move the header file to a
> > more appropriate location.
> 
> Acked-by: Mark Brown <broonie@kernel.org>

Thanks!

> I'm missing the rest of the series and/or the cover letter...

I meanwhile send cover letters only to all mailing lists involved. I
used to CC the individuals, too, until those messages were rejected
because the CC list grew too large :( And I really only CCed maintainers
then, no git history used.

If you were not CCed on the other patches, then you are likely not
listed as a maintainer for them?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170522/29c65ea0/attachment.sig>
