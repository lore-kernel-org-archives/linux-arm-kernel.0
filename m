From: contact@paulk.fr (Paul Kocialkowski)
Date: Fri,  7 Sep 2018 18:33:45 +0200
Subject: [PATCH 0/2] Follow-up patches for Cedrus v9
Message-ID: <20180907163347.32312-1-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This brings the requested modifications on top of version 9 of the
Cedrus VPU driver, that implements stateless video decoding using the
Request API.

Paul Kocialkowski (2):
  media: cedrus: Fix error reporting in request validation
  media: cedrus: Add TODO file with tasks to complete before unstaging

 drivers/staging/media/sunxi/cedrus/TODO     |  7 +++++++
 drivers/staging/media/sunxi/cedrus/cedrus.c | 15 ++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)
 create mode 100644 drivers/staging/media/sunxi/cedrus/TODO

-- 
2.18.0
