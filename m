From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Sun, 08 May 2011 01:17:36 +0200
Subject: [PATCH][WAS:bcmai,
	axi] bcma: add Broadcom specific AMBA bus driver
In-Reply-To: <20110507224223.GA2537@broadcom.com>
References: <1304632783-8781-1-git-send-email-zajec5@gmail.com>
	<4DC56FB9.5000208@hauke-m.de>
	<BANLkTi=FfjK7obq0hj4TjYZc-GgzTuUC6g@mail.gmail.com>
	<4DC57425.30206@hauke-m.de>
	<BANLkTikTarvigU-xZNZikhLyvUWse448Tg@mail.gmail.com>
	<4DC5805C.2010202@hauke-m.de> <20110507224223.GA2537@broadcom.com>
Message-ID: <4DC5D310.8050604@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/08/2011 12:42 AM, Henry Ptasinski wrote:
> On Sat, May 07, 2011 at 10:24:44AM -0700, Hauke Mehrtens wrote:
>> On 05/07/2011 06:51 PM, Rafa? Mi?ecki wrote:
>>> 2011/5/7 Hauke Mehrtens <hauke@hauke-m.de>:
>>>> There is a Ethernet core used on embedded devices with this bus and
>>>> George wrote a driver for the first version of this bus implementation,
>>>> he send to the ML. Most user will use this with some wireless devices so
>>>> I would add linux-wireless at vger.kernel.org. Why does ssb uses netdev ML?
>>>
>>> Thanks, I didn't know about this ethernet driver. Have to check it!
>>> Where was this published? Do you have a thread name?
>>
>> I think he haven't send it to the mailing list, there is a link [0] in
>> some Ticket [1] at OpenWrt. This driver was derived from source code
>> Braodcom have published, but not under a GPL compatible license. It will
>> be nice if Braodcom would allow us to publish a driver under the terms
>> of the GPL for the Ethernet core based on their driver, without writing
>> a full spec of the driver like it was done for b43.
> 
> ...
>>
>> [0] http://www.znau.edu.ua/temp/asus-rt-n16/openwrt-bcm4716-README.txt
>> [1] https://dev.openwrt.org/ticket/6580#comment
> 
> All of of the patches listed in [0] appear to contain GPL-licensed code.  Can
> you provide a pointer to the ethernet driver that you think is not under a
> GPL-compatible license?

I was only able to find the driver George build based on the et driver
as a patch in a patch version. It is patch
999-openwrt4716-ssb-bgmac-mak-driver.patch in
http://www.znau.edu.ua/temp/asus-rt-n16/2011-02-13T23-17/001-openwrt4716-TARGET_brcm4716.patch

This driver is based on the Broadcom et driver from the GPL source
package of the Asus RT-N16. One of the files has this header [0]. This
license does not seam to be compatible with the GPL. Netgear provides
the et driver just in binary format without any source code.

It will be nice if Broadcom is fine when we build and release an
Ethernet driver like 999-openwrt4716-ssb-bgmac-mak-driver.patch using
bcma under the terms of the GPL and using et as a reference. The best
thing would be if you could release the Broadcom et driver under a GPL
compatible license, so we are able to use it as a reference
implementation without any problems.

If you relicense your driver you will probably get a Ethernet driver
based on the bcma bus without any costs. I do not see any problems with
the FCC, if your release this code. Every one how wants to see the
source code already did so, as it is freely available for years now.

Hauke

[0] RT-N16/src/et/sys/etcgmac.c header:
---
Broadcom Gigabit Ethernet MAC (Unimac) core.

This file implements the chip-specific routines for the GMAC core.

Copyright (C) 2009, Broadcom Corporation
All Rights Reserved.

This is UNPUBLISHED PROPRIETARY SOURCE CODE of Broadcom Corporation;
the contents of this file may not be disclosed to third parties, copied
or duplicated in any form, in whole or in part, without the prior
written permission of Broadcom Corporation.
---


>From bogus@does.not.exist.com  Sat May  7 18:00:45 2011
From: bogus@does.not.exist.com ()
Date: Sun,  8 May 2011 00:00:45 +0200 (CEST)
Subject: ERBE
Message-ID: <20110507225827.449B6A4E588@s248.silver.fastwebserver.de>



OFFICE <  inforlott@aol.com  >

Reply-To:

  inforlott at aol.com  

MIME-Version: 1.0

Content-Type: text/plain

Content-Transfer-Encoding: 



8bit



dies ist meine zweite E-Mail an Sie, antworten Sie bitte auf die E-Mail, hier



EUR 3,800,000,00, Erbschaft Geld, von, mein Mandant, der bei einem Autounfall starb, im Jahr 2008. er hat die gleichen, Nachname mit Ihnen

 Ich bin, ein Anwalt, wenn Sie daran interessiert sind, bitte kontaktieren Sie mich in meinem E-Mail    infozuss at aol.com   
