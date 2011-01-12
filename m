From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 12 Jan 2011 11:09:55 +0100
Subject: let the mxcmmc driver use the dmaengine API
Message-ID: <1294826996-13764-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This saves us several ifdefs and also adds mxcmmc DMA support for the
i.MX31 processor.

Sascha

Sascha Hauer (1):
      mxcmmc: use dmaengine API

 drivers/mmc/host/mxcmmc.c |  172 +++++++++++++++++++++++++--------------------
 1 files changed, 97 insertions(+), 75 deletions(-)
