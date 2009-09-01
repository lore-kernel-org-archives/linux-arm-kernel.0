From: madhu.cr@ti.com (Madhusudhan)
Date: Tue, 1 Sep 2009 12:12:44 -0500
Subject: mmcqd seem to use lot of cpu cycles
Message-ID: <000301ca2b27$6c19a7a0$544ff780@am.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

 

While running one of the MMC use cases in the system I saw that mmcqd seems
to eat up a lot of cpu cycles. I saw a thread which discussed some details.

 

http://www.nabble.com/mmcqd-uses-a-large-amount-of-cpu-td23768078.html

 

Any clue on what this process is doing? If a low level driver is using DMA I
am not sure why there is so much load on the system due to mmcqd? Any
thoughts?

 

Regards,

Madhu

 

 

 

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20090901/a500ea75/attachment.htm>
