From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 14 May 2012 20:09:28 +0100
Subject: [PATCH] clkdev: Add default clkdev.h
In-Reply-To: <201205141903.04121.arnd@arndb.de>
References: <1337005167-22628-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <201205141903.04121.arnd@arndb.de>
Message-ID: <20120514190928.GJ25668@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2012 at 07:03:03PM +0000, Arnd Bergmann wrote:

> I'm not completely sure about this part. It should work just fine, but
> we haven't done this for any of the other asm/* headers. If we decide
> to list generic header files  in Kconfig.asm that automatically get
> added to architectures, I would prefer doing it with a nicer syntax so
> we can do it for a lot of the other header files too. For now, I'd
> prefer to just add the file manually to the asm/Kbuild files in the
> architectures where it makes sense (e.g. all but s390).

The problem with that is the general pain that seems to come from trying
to get all the architecture maintainers to apply patches like this (lots
of them are OK but many do great /dev/null impressions) and it's pushing
the problem back onto the wrong people.  It seems less work to go put
something ugly in and then hopefully some Kbuild expert will get annoyed
and fix things rather than we get stuck with the status quo.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120514/8cd3ea98/attachment-0001.sig>
