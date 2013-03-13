From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 13 Mar 2013 10:49:45 +0000
Subject: [PATCH 08/10] ASoC: dmaengine_pcm: Add open function for DT DMA
 request
In-Reply-To: <20130313021712.GD27461@S2101-09.ap.freescale.net>
References: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
 <1362940391-8338-9-git-send-email-mpa@pengutronix.de>
 <20130312190206.GY19942@opensource.wolfsonmicro.com>
 <20130313021712.GD27461@S2101-09.ap.freescale.net>
Message-ID: <20130313104945.GI25610@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 13, 2013 at 10:18:29AM +0800, Shawn Guo wrote:

> I did not see any objection from you on that patch, so I'm waiting for
> you to publish a branch for it, so that my mxs-dma generic binding
> series can move forward.

I commented on the removal of the const from the name parameter (and
ideally an in order version of the patch series would be nice) but in
general I was mostly waiting for review and test from other people.  DT
and dmaengine both seem endless sources of problems so I'd rather make
sure everyone's had a chance to look.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130313/99380e3e/attachment.sig>
