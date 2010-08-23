From: jason.mcmullan@netronome.com (Jason McMullan)
Date: Mon, 23 Aug 2010 12:39:03 -0400
Subject: Policy question: criteria for submission to mainline for a new
	SoC?
In-Reply-To: <201008231726.41399.marek.vasut@gmail.com>
References: <AANLkTimpz2YVTqd1EVqoX3yKKQ-peAy=OgwEDmz-iVi-@mail.gmail.com>
	<201008231726.41399.marek.vasut@gmail.com>
Message-ID: <AANLkTimzBeN2OzHkay5uNK1pK_w575NgAxJbcDmwYMby@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 23, 2010 at 11:26 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Most of the board init routines should be in Linux actually. It shouldn't depend
> on bootloader. Also, you might want to use uboot for linux instead of custom
> bootloader.

As much as I would like to, several of our board initialization
routines (specifically DDR3, TCAM, and RXAUI) are under NDA
by our suppliers, and can't be included in U-Boot.

> Why not just sticking the sources on the website somewhere ?

We're working on that.


-- 
Jason S. McMullan
Netronome Systems, Inc.
