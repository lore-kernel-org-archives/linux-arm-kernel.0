From: saquib.herman@gmail.com (Saquib)
Date: Thu, 5 May 2011 12:23:31 +0530
Subject: Duration of mdelay and udelay depends on MPU frequency in SMP
In-Reply-To: <BANLkTikGXzLba8uqXoffaUixBrEGj-XzRQ@mail.gmail.com>
References: <BANLkTikGXzLba8uqXoffaUixBrEGj-XzRQ@mail.gmail.com>
Message-ID: <BANLkTimVPnzMCL=NMb7hDkL97nJ=XdFExw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Can anyone please help me to understand and fix this issue?

When CPU frequency is "1008MHz", duration of delay was close to theoretical
value, however, when "300MHz", it was close to about 4 times the theoretical
value.

I tested it on OMAP4(SMP) blaze board.
-- 
Thanks & regards,
Saquib
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110505/87732fff/attachment-0001.html>
