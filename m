From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 12 Mar 2014 12:39:37 +0000
Subject: [PATCH 0/5] ahci: st: Apply Bartlomiej's suggestions 
Message-ID: <1394627982-23726-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tejun,

Sorry for the delay, I was in Asia for 9 days last week.

Here are the suggestions from Bartlomiej's review.

 drivers/ata/Kconfig   |  8 ++++----
 drivers/ata/ahci_st.c | 54 ++++++++++++++++++++++++++++++++----------------------
 2 files changed, 36 insertions(+), 26 deletions(-)
