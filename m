From: broonie@kernel.org (Mark Brown)
Date: Fri, 5 Jul 2013 22:19:20 +0100
Subject: [PATCH] ASoC: Allow imx-pcm-{dma,fiq}.c to be modules
In-Reply-To: <201307052255.10765.arnd@arndb.de>
References: <201307051745.16140.arnd@arndb.de>
 <20130705173321.GE27646@sirena.org.uk>
 <201307052255.10765.arnd@arndb.de>
Message-ID: <20130705211920.GK27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 05, 2013 at 10:55:10PM +0200, Arnd Bergmann wrote:
> On Friday 05 July 2013, Mark Brown wrote:

> > Is this actually OK with the FIQ APIs?

> I don't know. Why wouldn't it?

It was the only reason I could think of why that'd have been done.

> Other users of the same interfaces (mx1_camera, spi-s3c24xx) can also be
> modules, so I wouldn't expect a fundamental issue.

OK.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130705/c6dd9378/attachment.sig>
