From: addy.ke@rock-chips.com (Addy Ke)
Date: Mon,  9 Feb 2015 15:25:24 +0800
Subject: [PATCH v2 0/2] about data busy
In-Reply-To: <1423134801-23219-1-git-send-email-addy.ke@rock-chips.com>
References: <1423134801-23219-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <1423466726-20833-1-git-send-email-addy.ke@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Addy Ke (2):
  mmc: dw_mmc: fix bug that cause 'Timeout sending command'
  mmc: dw_mmc: Don't start command while data busy

 drivers/mmc/host/dw_mmc.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

-- 
Changes in v2:
- add new patch to handle data busy when start command
- add cpu_relaxed, suggested by Daniel Kurtz <djkurtz@chromium.org>
1.8.3.2
