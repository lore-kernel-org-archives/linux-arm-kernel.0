From: xerofoify@gmail.com (nick)
Date: Sat, 20 Dec 2014 01:22:31 -0500
Subject: Revisiting  Limitations  in fimic-isp.h
Message-ID: <549515A7.2000302@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greetings Maintainers,
I am wondering about these constraints : 
/* FIXME: revisit these constraints */
#define FIMC_ISP_SINK_WIDTH_MIN         (16 + 8)
#define FIMC_ISP_SINK_HEIGHT_MIN        (12 + 8)
#define FIMC_ISP_SOURCE_WIDTH_MIN       8
#define FIMC_ISP_SOURCE_HEIGHT_MIN      8
#define FIMC_ISP_CAC_MARGIN_WIDTH       16
#define FIMC_ISP_CAC_MARGIN_HEIGHT      12

#define FIMC_ISP_SINK_WIDTH_MAX         (4000 - 16)
#define FIMC_ISP_SINK_HEIGHT_MAX        (4000 + 12)
#define FIMC_ISP_SOURCE_WIDTH_MAX       4000
#define FIMC_ISP_SOURCE_HEIGHT_MAX      4000

#define FIMC_ISP_NUM_FORMATS            3
#define FIMC_ISP_REQ_BUFS_MIN           2
#define FIMC_ISP_REQ_BUFS_MAX           32

#define FIMC_ISP_SD_PAD_SINK            0
#define FIMC_ISP_SD_PAD_SRC_FIFO        1
#define FIMC_ISP_SD_PAD_SRC_DMA         2
#define FIMC_ISP_SD_PADS_NUM            3
#define FIMC_ISP_MAX_PLANES     
Whenever you get around to it, please tell if there are any issues here we need to clean up as the numbers 
seem fine to me. Unfortunately, I didn't write the driver so I am double checking with the writers to make
sure I aren't missing something :).
Thanks,
Nick  
