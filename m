From: zhang.zhilong@gmail.com (Zhilong zhang)
Date: Thu, 25 Nov 2010 16:26:24 +0800
Subject: composite gadget driver want use 8 endpoints ,but my mcu only has 6
	endpoints include control ep0
Message-ID: <AANLkTim1UdMV4+0y5Rk-1yz+zRJPsWG1kB2tDUzBj4cm@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,everyone.

I want to write a composite gadget driver which can supply 3
functions:printer, scanner, modem communication . The mcu is at91sam9263
which has 6 endpoints.
and my printer interface use 2 endpoints , scanner use 3 endpoints and modem
comm use 2 endpoints and a control endpoint. And the endpoints are more than
6 endpoints include ep0.

How can I do? Can I alloc 2 endpoints for both printer and modem comm?

regard your reply.
Thank you .

-- 
Zhang Zhilong
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101125/b84fa9c3/attachment-0001.html>
