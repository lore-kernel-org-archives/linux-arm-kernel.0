From: vipulkumar.samar@st.com (Vipul Kumar Samar)
Date: Wed, 26 Sep 2012 16:54:05 +0530
Subject: [PATCH 0/2] ARM: AMBA: Fix clock disable/enable issue in conventional
 suspend/resume
Message-ID: <1348658647-25975-1-git-send-email-vipulkumar.samar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vipul Kumar Samar (2):
  spi:pl022: Disable/Enable functional clock from suspend/resume
  ARM: ABMA: Disable/Enable interface clock from suspend/resume

 drivers/amba/bus.c      |   42 +++++++++++++++++++++++++++++++++++++++---
 drivers/spi/spi-pl022.c |    8 ++++++++
 2 files changed, 47 insertions(+), 3 deletions(-)

-- 
1.7.10
