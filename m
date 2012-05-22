From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Tue, 22 May 2012 12:09:09 +0200
Subject: [PATCH v3 0/3] atmel-mci device tree support 
Message-ID: <1337681352-18521-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch-set adds device tree support for atmel-mci.

Regards

Ludovic

v3:
- use cd-inverted instead of cd-invert to follow mmc common binding.
- don't assign a pointer to pdev->dev.platform.
- add mci controller nodes to other chips and boards.
- put all dts file changes together.

v2:
- squash patch v1 2/4 and 3/4.
- change atmci_get_of_slots to atmci_of_init and manage pdata allocation into
it.
- correct potential issue (e.g. having only one slot which is not slot0 into
the dt) about slots by adding a reg property corresponding to the slot id.
