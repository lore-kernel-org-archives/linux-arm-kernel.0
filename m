From: lori.hikichi@broadcom.com (Lori Hikichi)
Date: Thu, 28 Sep 2017 15:29:31 -0700
Subject: [PATCH v1 0/3] Minor updates to driver 
Message-ID: <1506637775-18293-1-git-send-email-lori.hikichi@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains a few small updates to the DAI driver. 

Lori Hikichi (3):
  ASoC: cygnus: Add EXPORT_SYMBOL for helper function
  ASoC: cygnus: Remove set_fmt from SPDIF dai ops
  ASoC: cygnus: Remove support for 8 bit audio and for mono

 sound/soc/bcm/cygnus-ssp.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

-- 
1.9.1
