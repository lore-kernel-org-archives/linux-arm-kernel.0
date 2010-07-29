From: colin.tuckley@arm.com (Colin Tuckley)
Date: Thu, 29 Jul 2010 14:31:48 +0100
Subject: [PATCH 02/12] mmci: fix multi block transfers
In-Reply-To: <20100729131858.GB18923@n2100.arm.linux.org.uk>
References: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>	<1277198267-10860-2-git-send-email-rabin.vincent@stericsson.com>
	<20100729131858.GB18923@n2100.arm.linux.org.uk>
Message-ID: <000001cb2f22$65576150$300623f0$@tuckley@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Russell King - ARM

> So this is good news.  I've applied the first three patches in this
> series, but we do need to sort out the card detect situation properly
> before continuing.

On the subject of card detection. I recently noticed that although it works
on the PB926 it doesn't on the AB926 despite it being the same kernel
binary. On the AB926 the detection is doing something when a card is
inserted but the device never appears.

Colin

--
Colin Tuckley - ARM Ltd.
110 Fulbourn Rd
Cambridge, CB1 9NJ
Tel: +44 1223 400536
