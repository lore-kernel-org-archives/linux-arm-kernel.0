From: petr.cvek@tul.cz (Petr Cvek)
Date: Fri, 24 Feb 2017 02:53:32 +0100
Subject: [PATCH v2 0/2] usb: gadget: pxa27x: Duplicated definition and valid
 pointer fixes
Message-ID: <8c31a5a9-f6e9-d406-c7b3-6805bb416286@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two simple fixes for pxa27x gadget UDC. First one remove function declaration
duplication, second one add test for a valid pointer before function call as
it can be called with an error value in the pointer.

Changes from v1:
 * Shorter titles, corrected Robert Jarzmik's signature

Petr Cvek (2):
  usb: gadget: pxa27x: Remove duplicate function prototype
  usb: gadget: pxa27x: Test for a valid argument pointer

 drivers/usb/gadget/udc/pxa27x_udc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

-- 
2.11.0
