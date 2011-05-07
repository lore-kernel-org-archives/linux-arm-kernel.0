From: george@znau.edu.ua (George Kashperko)
Date: Sat, 07 May 2011 20:45:24 +0300
Subject: [PATCH][WAS:bcmai,axi] bcma: add Broadcom specific AMBA bus driver
In-Reply-To: <4DC5805C.2010202@hauke-m.de>
References: <1304632783-8781-1-git-send-email-zajec5@gmail.com>
	<4DC56FB9.5000208@hauke-m.de>
	<BANLkTi=FfjK7obq0hj4TjYZc-GgzTuUC6g@mail.gmail.com>
	<4DC57425.30206@hauke-m.de>
	<BANLkTikTarvigU-xZNZikhLyvUWse448Tg@mail.gmail.com>
	<4DC5805C.2010202@hauke-m.de>
Message-ID: <1304790324.13983.5.camel@dev.znau.edu.ua>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> Some of the embedded devices also have a USB core on the BCMA bus and a
> pci(e) host controller to connect other pci(e) devices. As most of the
> patches for ssb came from the wireless guys and I do not thing this will
> be different for bcma, I thing the wireless mailing list is the correct
> place.
> 
> @George what is the status of adding support for the embedded devices?
Haven't been looking into Rafal's code closely yet. I'm working on
another solution suitable for SSB, AXI and hopefully UBUS as well but I
don't ready to publish it yet.

Regarding ethernet driver, still no feedback on GPL-friendly licensing
possibility for the code from Broadcom.

Have nice day,
George
