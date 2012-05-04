From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 4 May 2012 23:09:45 +0100
Subject: Handling of modular boards
In-Reply-To: <20120504203357.6B79B206451@gemini.denx.de>
References: <20120504185850.GO14230@opensource.wolfsonmicro.com>
 <201205041934.08830.arnd@arndb.de>
 <20120504203357.6B79B206451@gemini.denx.de>
Message-ID: <20120504220944.GT14230@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2012 at 10:33:57PM +0200, Wolfgang Denk wrote:

> On the other hand, some of the issues we're trying to solve here
> for the kernel are also present in the boot loader, so this needs to
> do this anyway - whether by inserting new or modifying (enabling or
> disabling) existing properties in the DT is not really relevant here.

FWIW if the bootloader can usefully handle this stuff I think that's a
good approach but there is substantial variation in quality of
implementation between bootloaders and even when the bootloader is a
good one it's not always practical to update it or the data it relies
on.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120504/61cb0296/attachment-0001.sig>
