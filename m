From: petr.cvek@tul.cz (Petr Cvek)
Date: Thu, 23 Feb 2017 02:35:02 +0100
Subject: [PATCH 0/2] usb: gadget: Fixes for pxa27x_udc
Message-ID: <3777b08c-8cf5-3e7b-8d63-d4acfbe8e286@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two simple fixes for pxa27x gadget UDC. First one remove function declaration
duplication, second one add test for a valid pointer before function call as
it can be called with an error value in the pointer.

Petr Cvek (2):
  [TRIVIAL] usb: gadget: Remove duplicated function declaration in
    pxa27x_udc
  usb: gadget: Add test if argument pointer has a valid value in
    pxa27x_udc

 drivers/usb/gadget/udc/pxa27x_udc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

-- 
2.11.0
