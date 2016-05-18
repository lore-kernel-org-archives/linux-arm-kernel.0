From: m.gardet@overkiz.com (Mickael GARDET)
Date: Wed, 18 May 2016 10:04:35 +0200
Subject: at91 slow clock with an external crystal (on Atmel SAM9G25)
Message-ID: <9cf2f9be-7f76-ca65-f2cf-ca0d20de6d2f@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have one question about usage of slow clock with an external crystal 
(on Atmel SAM9G25).

All work fine If I set CONFIG_SCLK=y in at91bootstrap but we wouldn't 
update at91bootstrap.

If I force usage of external crystal (like the enclosed patch) it work 
for me but what's the recommended way to do this ?

My kernel version is 4.1.13.

Best regards.
Mickael GARDET


-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0003-force_external_osc.patch
Type: text/x-patch
Size: 2077 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160518/2a4552b7/attachment.bin>
