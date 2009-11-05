From: jassi.brar@samsung.com (Jassi Brar)
Date: Thu,  5 Nov 2009 13:44:13 +0900
Subject: S3C64XX DMA driver fixes
Message-ID: <1257396253-32108-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
  Following are a few patches against 
 http://www.fluff.org/git/bjdooks/linux.git fixes-s3c64xx-dma
 commit 7ec6b719e4f75f9e73b610b7a71255d639cd566b

 Among other things, the patches enable the PL-080 driver to
 work with non-circular buffer queues as well. The implementation
 was tested with I2S driver by making s3c_dma_has_circular() return
 false. My not-yet-submitting SPI driver works fine too after these
 patches.

Regards.
