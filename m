From: eric@anholt.net (Eric Anholt)
Date: Mon, 14 Nov 2016 16:39:41 -0800
Subject: [PATCH] ARM64: dts: bcm2837-rpi-3-b: remove incorrect pwr LED
In-Reply-To: <741880731.428971.a2c5fd60-1b30-481e-b728-fc62c8d1c81a.open-xchange@email.1und1.de>
References: <20161111173821.21491-1-eric@anholt.net>
 <741880731.428971.a2c5fd60-1b30-481e-b728-fc62c8d1c81a.open-xchange@email.1und1.de>
Message-ID: <871sydfueq.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Hi Eric,
>
> [add Gerd to CC]
>
>> Eric Anholt <eric@anholt.net> hat am 11. November 2016 um 18:38 geschrieben:
>> 
>> 
>> From: Andrea Merello <andrea.merello@gmail.com>
>> 
>> We are incorrectly defining the pwr LED, attaching it to a gpio line
>> that is wired to the Wi-Fi SDIO module (which fails due to this).
>
> i agree with the intention of this patch, but is the upstream kernel really
> affected? I can't see any compatible for the Wifi interface.

The wifi isn't in the DT yet because the driver isn't merged.  Some
progress was made on that a while ago, but people asked for more
cleanups so it's still living out of tree.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161114/aeaf51d8/attachment.sig>
