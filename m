From: valmikibow@gmail.com (valmiki)
Date: Tue, 14 Jun 2016 14:58:36 +0000 (UTC)
Subject: Why MSI is limited to 32 MSI's per device
Message-ID: <loom.20160614T164843-937@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Why MSI interrupts are limited to 32 per device ?
We have 16 bit data, with which we can have 2^16 combinaitons of different
data, which in turn those many MSI vectors.

Other than increase in number interrupts to 2048 in MSI-X, what advantage we
get by using MSI-X over MSI.

I read MSI-X interrupts can be targeted to different CPU's in an SMP system.
why can't MSI interrupts can be targeted to different processors ?  


Thanks & Regards,
Valmiki
 
