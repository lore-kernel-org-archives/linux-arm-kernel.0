From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 5 Jul 2012 10:38:08 +0100
Subject: How to handle parameter variation across different boards but
 same platform
In-Reply-To: <201207050832.16750.arnd@arndb.de>
References: <1BAFE6F6C881BF42822005164F1491C33EA3532A@DBDE01.ent.ti.com>
 <20120704142745.GC4111@opensource.wolfsonmicro.com>
 <4FF52948.6090904@ti.com> <201207050832.16750.arnd@arndb.de>
Message-ID: <20120705093808.GJ4111@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 05, 2012 at 08:32:16AM +0000, Arnd Bergmann wrote:
> On Thursday 05 July 2012, Vaibhav Hiremath wrote:

> > Does machine ID still gets set? May be I am missing something...

> No, it doesn't.

This is a *really* unfortunate decision, BTW - it means that if your
bootloader has a device tree available it needs to know if the kernel
it's booting is DT or non-DT which is just generally unhelpful.  Sadly I
don't hold out much hope of being able to fix it, though.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120705/302e1c8a/attachment.sig>
