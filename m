From: david@lechnology.com (David Lechner)
Date: Wed,  9 Mar 2016 17:50:01 -0600
Subject: [PATCH 0/4] davinci_mmc device tree fixes
Message-ID: <1457567405-30475-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm working on getting a davinci device working with device tree. I came across
some issues in the davinci_mmc driver.

David Lechner (4):
  mmc: davinci: remove matching string
  mmc: davinci: fix unwinding in probe
  mmc: davinci: prepare clock
  mmc: davinci: suppress waring when using DT

 drivers/mmc/host/davinci_mmc.c | 86 ++++++++++++++++++++----------------------
 1 file changed, 41 insertions(+), 45 deletions(-)

-- 
1.9.1
