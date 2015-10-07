From: bharatku@xilinx.com (bharat kumar gogada)
Date: Wed, 7 Oct 2015 15:29:28 +0000 (UTC)
Subject: when to use =?utf-8?b?ZGV2bV9yZXF1ZXN0X2lycQ==?= and
 =?utf-8?b?aXJxX3NldF9jaGFpbmVkX2hhbmRsZXJfYW5kX2RhdGE=?=
Message-ID: <loom.20151007T172212-792@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

when to use devm_request_irq and when to use irq_set_chained_handler_and_data.
I see that some drivers are not using devm_request_irq instead using
irq_set_chained_handler_and_data for setting up irq handling.

If we use  irq_set_chained_handler_and_data will it show up in cat
/proc/interrupts
