From: ynvich@gmail.com (Sergei Ianovich)
Date: Mon, 16 Dec 2013 16:03:56 +0400
Subject: [PATCH v2 03/16] ARM: dts: provide DMA config to pxamci
In-Reply-To: <52AEEAF4.3010703@metafoo.de>
References: <1386543229-1542-1-git-send-email-ynvich@gmail.com>
 <1386901645-28895-1-git-send-email-ynvich@gmail.com>
 <1386901645-28895-4-git-send-email-ynvich@gmail.com>
 <201312142006.26979.arnd@arndb.de>
 <1387049660.7152.317.camel@host5.omatika.ru> <52AECEB2.4070807@gmail.com>
 <1387194450.13062.134.camel@host5.omatika.ru> <52AEEAF4.3010703@metafoo.de>
Message-ID: <1387195436.13062.139.camel@host5.omatika.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-12-16 at 12:58 +0100, Lars-Peter Clausen wrote:
> Btw. any driver that parses the dmas property manually should be considered
> broken. This is a classical layering violation. The layout of the dma
> specifier is DMA controller specific and should be completely transparent to
> the device driver.

PXA as a whole is broken in this respect at the moment. The problem is
how to move to a "fixed" state without breaking things which work now.
