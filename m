From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 16 Aug 2010 13:07:47 +0200
Subject: [RFC] dmaengine: assorted patches and Freescale SDMA support
Message-ID: <1281956870-12463-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is the first attempt to implement the Freescale i.MX SDMA engine
as part of the dmaengine API.

The first patch adds support for cyclic transfers usable for audio. There
is a similar approach implemented for the dw_dmac, this patch instead adds
the cyclic transfers to the dmaengine API.

Other patches not posted here are necessary to actually make use of the
SDMA engine. Please pull the following branch if you want to test these
patches. The branch includes mxcmmc support for the i.MX31 based on SDMA
and i.MX35-3stack audio support (sgtl5000 codec):

http://git.pengutronix.de/git/imx/linux-2.6.git sdma-sdmaengine

For generating firmware images for the SDMA engine look at

http://git.pengutronix.de/git/imx/sdma-firmware.git

Sascha
