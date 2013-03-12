From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 12 Mar 2013 19:02:07 +0000
Subject: [PATCH 08/10] ASoC: dmaengine_pcm: Add open function for DT DMA
 request
In-Reply-To: <1362940391-8338-9-git-send-email-mpa@pengutronix.de>
References: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
 <1362940391-8338-9-git-send-email-mpa@pengutronix.de>
Message-ID: <20130312190206.GY19942@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 10, 2013 at 07:33:09PM +0100, Markus Pargmann wrote:
> Add a function to open a DMA PCM substream using devicetree data
> provided via the client device node. The patch introduces a public
> function and a private subfunction that is called by both open
> functions.

Someone (I think it was Shawn) sent a very similar patch just recently
which appears to have fallen out of my inbox unfortunately - can you
please check what's going on there and coordinate with them?  Let me
know if you can't find the patch and I'll dig it out.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130312/5a378340/attachment-0001.sig>
