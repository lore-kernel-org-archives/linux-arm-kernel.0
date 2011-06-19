From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sun, 19 Jun 2011 16:23:47 +0200
Subject: irq flood with mmc boot partitions on s3c2416 with 3.0rc1
In-Reply-To: <BANLkTinCyr=pL9tyK+F9XxX2r15acqEsNA@mail.gmail.com>
References: <201106022149.47936.heiko@sntech.de>
	<BANLkTinCyr=pL9tyK+F9XxX2r15acqEsNA@mail.gmail.com>
Message-ID: <201106191623.48470.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag 18 Juni 2011, 22:56:11 schrieb Daniel Mack:
> On Thu, Jun 2, 2011 at 9:49 PM, Heiko St?bner <heiko@sntech.de> wrote:
> > Hi,
> > 
> > after upgrading my development kernel from 2.6.38 to 3.0rc1 I get flooded
> > (i.e.
> 
> > it never stops) by messages of the form:
> Even though it's not really related to SDIO, does reverting 06e8935
> ("mmc: sdio: optimized SDIO IRQ handling for single irq") fix your
> problem?
sadly reverting this commit didn't fix the problem.
It still floods everything with CMD13s and interrupts

Heiko
