From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 28 Mar 2012 11:57:45 +0100
Subject: [PATCH 4/4] ARM i.MX 3ds debugboard: register a dummy regulator
 for the smsc911x device
In-Reply-To: <20120326181912.GV3852@pengutronix.de>
References: <1330774804-7310-1-git-send-email-s.hauer@pengutronix.de>
 <1330774804-7310-5-git-send-email-s.hauer@pengutronix.de>
 <CAOMZO5DL8YQT2qb=vxdQtdN+zfZLK9H9_1qu5sS+1YAvSo5SAA@mail.gmail.com>
 <20120326181912.GV3852@pengutronix.de>
Message-ID: <20120328105745.GH3232@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 26, 2012 at 08:19:12PM +0200, Sascha Hauer wrote:

> At least it did work when I sent the patches, but -EPROBE_DEFER did not
> exist at that time. Do you have the fixed regulator enabled in your
> config?

FWIW all the -EPROBE_DEFER change does is change the error code returned
when we can't find a supply, if we're hitting that case we'd have failed
without it too.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120328/894a0e26/attachment-0001.sig>
