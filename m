From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 7 May 2012 16:28:03 +0100
Subject: [PATCH 1/2] mfd: max8925: request resource region
In-Reply-To: <201205071515.08179.arnd@arndb.de>
References: <1336360249-29963-1-git-send-email-haojian.zhuang@gmail.com>
 <201205071319.48768.arnd@arndb.de>
 <20120507141551.GE17002@opensource.wolfsonmicro.com>
 <201205071515.08179.arnd@arndb.de>
Message-ID: <20120507152802.GJ17002@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 07, 2012 at 03:15:08PM +0000, Arnd Bergmann wrote:

> The part that confuses me most about the abuse of IORESOURCE_IO is that
> these have no parent resource and are not registered or listed in
> /proc/ioports.

Well, if you're going to get confused about that sort of stuff there's
also the fact that we've got platform devices which aren't the sort of
simple memory mapped things that the platform bus is supposed to be for
since any other bus for this sort of stuff would just be a straight
copy of the platform bus.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120507/081ec910/attachment.sig>
