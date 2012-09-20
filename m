From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Sep 2012 15:53:06 +0200
Subject: [PATCH] ARM: mxs: m28evk: Disable OCOTP OUI loading
In-Reply-To: <201209201510.24631.marex@denx.de>
References: <1348007837-23187-1-git-send-email-marex@denx.de>
 <201209201420.55526.marex@denx.de> <20120920125631.GC2609@pengutronix.de>
 <201209201510.24631.marex@denx.de>
Message-ID: <505B1FC2.2090609@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

Le 20/09/2012 15:10, Marek Vasut a ?crit :
>>> If barebox can't handle even basic DT fixup, it's broken.
>>
>> It can. It maybe was just not needed up to now, dunno.
> 
> Fix it and send patch, so this problem doesn't spread.

I'm sorry, but you still miss the point.

If someone wants to use another bootloader than U-boot (or a possible
patched barebox), or none other than the bootlets to boot directly the
Linux (with an appended device tree), you will still have no way to get
the NIC from the OCOTP, and I'm sorry, but it is just wrong.

The kernel shouldn't rely on a particular feature of a given bootloader.

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
