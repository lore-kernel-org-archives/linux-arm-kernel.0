From: hemantp@ti.com (Pedanekar, Hemant)
Date: Fri, 9 Jul 2010 07:46:31 +0530
Subject: Memory type used for ioremap
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030E181724@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I have few doubts regarding the memory type configured when we call ioremap for mapping a region (e.g., on-chip peripheral MMRs):

Please note that this is regarding Cortx A8.

After examining 2nd level page descriptor, I see that the memory type configured for ioremapped region (as per TEX[2:0]=1 and CB=0) is "Outer and Inner Non-cacheable - Normal". Is this correct observation? I thought the ioremap would set memory type as one of the "Device".

What is the recommended method if I want to map some region as "Strongly-ordered" or "Device"?

Thanks
-
Hemant


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100709/0b637f70/attachment.html>
