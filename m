From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 09 Jun 2011 21:57:06 +0530
Subject: [linux-pm] [RFC PATCH v4] ARM hibernation/suspend-to-disk support
In-Reply-To: <20110609154058.GA24424@n2100.arm.linux.org.uk>
References: <alpine.DEB.2.00.1106071722040.2236@localhost6.localdomain6>	<201106072348.44624.rjw@sisk.pl>	<alpine.DEB.2.00.1106091604180.11513@localhost6.localdomain6>
	<20110609154058.GA24424@n2100.arm.linux.org.uk>
Message-ID: <4DF0F45A.3030103@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/9/2011 9:10 PM, Russell King - ARM Linux wrote:
> On Thu, Jun 09, 2011 at 04:30:08PM +0100, Frank Hofmann wrote:
>> Btw, when testing this I found that generic cpu_suspend seems to be just
>> fine for OMAP3; the OMAP platforms though do not at this time use the
>> generic cpu_suspend/resume for sleep, is it planned to change that ?
>
> That's because OMAP was doing changes to their sleep code while I was
> consolidating the sleep code, and although I asked several times that
> the OMAP folk should participate in this effort, but evidentally I was
> unsuccessful in achieving anything in that direction.
>
Agreed but the situation at that point was the code was not at
all in convertible position. Looking at your below comment,
it's still not :)

> And of course since then it's been forgotten about, and I've given up
> on that particular aspect.  I've also come to the conclusion that OMAP
> is sufficiently weird (requiring soo much to execute from SRAM) that
> its hopeless to persue.
>
We did discuss this Russell and requested your help here. I guess
you have already looked at OMAP code from generic suspend
hooks point of view and the SRAM execution, Errata's seems to
make you feel it's not going to work.
Is that what you mean here ?

Regards
Santosh
