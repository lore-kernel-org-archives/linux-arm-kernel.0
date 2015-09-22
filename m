From: josh.wu@atmel.com (Josh Wu)
Date: Tue, 22 Sep 2015 13:14:29 +0800
Subject: [PATCH 0/5] media: atmel-isi: enable preview path to output RGB565
 format
Message-ID: <1442898875-7147-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series will enable preview path support in atmel-isi. Which can
make atmel-isi convert the YUV format (from sensor) to RGB565 format.


Josh Wu (5):
  media: atmel-isi: correct yuv swap according to different sensor
    outputs
  media: atmel-isi: prepare for the support of preview path
  media: atmel-isi: add code to setup correct resolution for preview
    path
  media: atmel-isi: setup YCC_SWAP correctly when using preview path
  media: atmel-isi: support RGB565 output when sensor output YUV formats

 drivers/media/platform/soc_camera/atmel-isi.c | 181 ++++++++++++++++++++------
 drivers/media/platform/soc_camera/atmel-isi.h |  10 ++
 2 files changed, 148 insertions(+), 43 deletions(-)

-- 
1.9.1
