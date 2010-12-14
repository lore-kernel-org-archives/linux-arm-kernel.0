From: tomi.valkeinen@nokia.com (Tomi Valkeinen)
Date: Tue, 14 Dec 2010 14:23:51 +0200
Subject: Mainline OMAP3 breakage (and other OMAP?)
In-Reply-To: <20101203130724.GB30957@n2100.arm.linux.org.uk>
References: <20101202211421.GG10461@n2100.arm.linux.org.uk>
	<20101202215837.GW17222@atomide.com>
	<20101202221612.GJ10461@n2100.arm.linux.org.uk>
	<20101202223208.GA17222@atomide.com>
	<20101203030954.GD3367@linux-sh.org>
	<20101203084102.GA30957@n2100.arm.linux.org.uk>
	<AANLkTim3573_MUZNpo2+tKa=ZJgQf26x5of_ZkMM6BR8@mail.gmail.com>
	<20101203130724.GB30957@n2100.arm.linux.org.uk>
Message-ID: <1292329431.6893.113.camel@tubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, 2010-12-03 at 13:07 +0000, ext Russell King - ARM Linux wrote:

> So please, 2MB, or if you object, at the _very_ _least_ 1MB.  But
> definitely not PAGE_SIZE.

Here's a patch for this. Works for me on OMAP3430SDP. If the patch is
ok, I'll send a pull request to Paul.
