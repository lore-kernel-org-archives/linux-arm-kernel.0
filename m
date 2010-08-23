From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 23 Aug 2010 19:12:04 +0200
Subject: Policy question: criteria for submission to mainline for a new
	SoC?
In-Reply-To: <20100823165317.GC20369@sirena.org.uk>
References: <AANLkTimpz2YVTqd1EVqoX3yKKQ-peAy=OgwEDmz-iVi-@mail.gmail.com>
	<AANLkTimzBeN2OzHkay5uNK1pK_w575NgAxJbcDmwYMby@mail.gmail.com>
	<20100823165317.GC20369@sirena.org.uk>
Message-ID: <201008231912.04970.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne Po 23. srpna 2010 18:53:17 Mark Brown napsal(a):
> On Mon, Aug 23, 2010 at 12:39:03PM -0400, Jason McMullan wrote:
> > On Mon, Aug 23, 2010 at 11:26 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> > > Most of the board init routines should be in Linux actually. It
> > > shouldn't depend on bootloader. Also, you might want to use uboot for
> > > linux instead of custom bootloader.
> > 
> > As much as I would like to, several of our board initialization
> > routines (specifically DDR3, TCAM, and RXAUI) are under NDA
> > by our suppliers, and can't be included in U-Boot.
> 
> If you're doing this please make sure you provide a method for customers
> to customise the machine type (and get the rest of the boot protocol
> right).

You can still release the code, can't you ? Or the NDA is so restrictive it 
covers even the code?

Cheers
