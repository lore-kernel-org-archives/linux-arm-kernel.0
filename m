From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 27 Jan 2012 11:27:51 +0000
Subject: [PATCH 0/4] Pending S3C64xx updates
In-Reply-To: <016501ccdc93$ae158190$0a4084b0$%kim@samsung.com>
References: <20120124213127.GH1135@opensource.wolfsonmicro.com>
 <016501ccdc93$ae158190$0a4084b0$%kim@samsung.com>
Message-ID: <20120127112751.GF32008@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2012 at 10:33:24AM +0900, Kukjin Kim wrote:
> Mark Brown wrote:

> >       ARM: S3C64XX: Define some additional always off clocks

> Hmm, I know there were discussions about this with Tomasz Figa and I was
> waiting for his submitting. But now this looks ok to me so will apply this.

The discussion there was around there being other out of tree drivers
that might at some point want to use these clocks - I don't think there
was any doubt that for current mainline this change makes sense.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120127/c826a4b5/attachment.sig>
