From: daniel@caiaq.de (Daniel Mack)
Date: Tue, 27 Apr 2010 09:50:12 +0200
Subject: [PATCH] ARM: mx3: Fix a race condition in mxcmmc
Message-ID: <20100427075012.GB30801@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch below is a result of more MMC/SDIO tests on MX31 hardware.
