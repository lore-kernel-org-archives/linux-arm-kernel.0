From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Sat, 17 Jan 2015 22:25:37 +0100
Subject: [PATCHv3 0/5] USB: host: Atmel OHCI and EHCI drivers improvements
In-Reply-To: <Pine.LNX.4.44L0.1501171524050.13485-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.1501171524050.13485-100000@netrider.rowland.org>
Message-ID: <1421529942-18437-1-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sylvain Rochet (5):
  USB: host: ehci_atmel: Add suspend/resume support
  USB: host: ohci_at91: Stop/start USB PLL for all sleep modes
  USB: host: ehci_atmel: Move global variables to private struct
  USB: host: ohci_at91: Move global variables to private struct
  USB: host: ohci_at91: usb_hcd_at91_probe(), remove useless stack
    initialisation

 drivers/usb/host/ehci-atmel.c | 102 +++++++++++++++++++++++++++++++----------
 drivers/usb/host/ohci-at91.c  | 104 +++++++++++++++++++++++++-----------------
 2 files changed, 138 insertions(+), 68 deletions(-)

-- 
2.1.4
