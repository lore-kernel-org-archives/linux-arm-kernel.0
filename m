From: saquib.herman@gmail.com (Saquib)
Date: Thu, 5 May 2011 12:19:59 +0530
Subject: Duration of mdelay and udelay depends on MPU frequency in SMP
Message-ID: <BANLkTikGXzLba8uqXoffaUixBrEGj-XzRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Can anyone please help me to understand and fix this issue?

When CPU frequency is "1008MHz", duration of delay was close to theoretical
value, however, when "300MHz", it was close to about 4 times the theoretical
value.

Please find the log  as attachments. I tested it on OMAP4(SMP) blaze board.

-- 
Thanks & regards,
Saquib
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110505/148a2b94/attachment-0001.html>
